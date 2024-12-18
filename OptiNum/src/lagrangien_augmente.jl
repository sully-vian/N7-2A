using LinearAlgebra
include("../src/newton.jl")
include("../src/regions_de_confiance.jl")
"""

Approximation d'une solution au problème 

    min f(x), x ∈ Rⁿ, sous la c c(x) = 0,

par l'algorithme du lagrangien augmenté.

# Syntaxe

    x_sol, f_sol, flag, nb_iters, μs, λs = lagrangien_augmente(f, gradf, hessf, c, gradc, hessc, x₀; kwargs...)

# Entrées

    - f      : (Function) la ftion à minimiser
    - gradf  : (Function) le gradient de f
    - hessf  : (Function) la hessienne de f
    - c      : (Function) la c à valeur dans R
    - gradc  : (Function) le gradient de c
    - hessc  : (Function) la hessienne de c
    - x₀     : (Vector{<:Real}) itéré initial
    - kwargs : les options sous formes d'arguments "keywords"
        • max_iter  : (Integer) le nombre maximal d'iterations (optionnel, par défaut 1000)
        • tol_abs   : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel   : (Real) la tolérence relative (optionnel, par défaut 1e-8)
        • λ₀        : (Real) le multiplicateur de lagrange associé à c initial (optionnel, par défaut 2)
        • μ₀        : (Real) le facteur initial de pénalité de la c (optionnel, par défaut 10)
        • τ         : (Real) le facteur d'accroissement de μ (optionnel, par défaut 2)
        • algo_noc  : (String) l'algorithme sans c à utiliser (optionnel, par défaut "rc-gct")
            * "newton"    : pour l'algorithme de Newton
            * "rc-cauchy" : pour les régions de confiance avec pas de Cauchy
            * "rc-gct"    : pour les régions de confiance avec gradient conjugué tronqué

# Sorties

    - x_sol    : (Vector{<:Real}) une approximation de la solution du problème
    - f_sol    : (Real) f(x_sol)
    - flag     : (Integer) indique le critère sur lequel le programme s'est arrêté
        • 0 : convergence
        • 1 : nombre maximal d'itération dépassé
    - nb_iters : (Integer) le nombre d'itérations faites par le programme
    - μs       : (Vector{<:Real}) tableau des valeurs prises par μk au cours de l'exécution
    - λs       : (Vector{<:Real}) tableau des valeurs prises par λk au cours de l'exécution

# Exemple d'appel

    f(x)=100*(x[2]-x[1]^2)^2+(1-x[1])^2
    gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
    hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
    c(x) =  x[1]^2 + x[2]^2 - 1.5
    gradc(x) = 2*x
    hessc(x) = [2 0; 0 2]
    x₀ = [1; 0]
    x_sol, _ = lagrangien_augmente(f, gradf, hessf, c, gradc, hessc, x₀, algo_noc="rc-gct")

"""
function lagrangien_augmente(f::Function, gradf::Function, hessf::Function, 
        c::Function, gradc::Function, hessc::Function, x₀::Vector{<:Real}; 
        max_iter::Integer=1000, tol_abs::Real=1e-10, tol_rel::Real=1e-8,
        λ₀::Real=2, μ₀::Real=10, τ::Real=2, algo_noc::String="rc-gct")

    k = 0
    β = 0.9
    eta = 0.1258925
    α = 0.1
    ε₀ = 1 / μ₀
    η₀ = eta / μ₀ ^ α

    x_sol = x₀
    f_sol = f(x_sol)
    flag  = -1
    nb_iters = 0
    μs = [μ₀] # vous pouvez faire μs = vcat(μs, μk) pour concaténer les valeurs
    λs = [λ₀]

    # initialisation des variables d'itération
    xₖ = x₀
    εₖ = ε₀
    ηₖ = η₀

    while (flag == -1)
        λₖ = λs[end]
        μₖ = μs[end]

        # λₖ scalaire
        L(x) = f(x) + λₖ * c(x) + μₖ / 2 * norm(c(x))^2
        gradL(x) = gradf(x) + (λₖ + μₖ * c(x)) * gradc(x)
        hessL(x) = hessf(x) + μₖ * gradc(x) * gradc(x)' + (λₖ + μₖ * c(x)) * hessc(x)

        if (algo_noc == "newton")
            # ε=0 pour ne pas vérifier les contraintes de stagnation
            xₖ₊₁,_,_,_,_ = newton(L, gradL, hessL, xₖ, tol_abs=εₖ , tol_rel=0,epsilon=0)
        elseif (algo_noc == "rc-cauchy")
            xₖ₊₁,_,_,_,_ = regions_de_confiance(L, gradL, hessL, xₖ, tol_abs=εₖ, tol_rel=0, epsilon=0, algo_pas="cauchy")
        elseif (algo_noc == "rc-gct")
            xₖ₊₁,_,_,_,_ = regions_de_confiance(L, gradL, hessL, xₖ, tol_abs=εₖ, tol_rel=0, epsilon=0, algo_pas="gct")
        else
            error("Pas d'algo portant le nom \"" * algo_noc * "\", les seuls choix possibles sont \"newton\", \"rc-cauchy\" et \"rc-gct\".")
        end

        if (norm(c(xₖ₊₁)) <= ηₖ) # mettre à jour (entre autres) les multiplicateurs
            λₖ₊₁ = λₖ + μₖ * c(xₖ₊₁)
            μₖ₊₁ = μₖ
            εₖ₊₁ = εₖ / μₖ
            ηₖ₊₁ = ηₖ / μₖ^β
        else # Autrement, mettre à jour (entre autres) le paramètre de pénalité
            λₖ₊₁ = λₖ
            μₖ₊₁ = τ * μₖ
            εₖ₊₁ = ε₀ / μₖ₊₁
            ηₖ₊₁ = eta / μₖ₊₁^α
        end
        k = k  + 1

        if (norm(gradf(xₖ₊₁)+λₖ₊₁*gradc(xₖ₊₁)) <= max(tol_rel * norm(gradf(x₀)+λ₀*gradc(x₀)), tol_abs)
            && norm(c(xₖ₊₁)) <= max(tol_rel * norm(c(x₀)), tol_abs))
			# CN1: différente (minimisation des contraintes)
			flag = 0
		# elseif (norm(xₖ₊₁ - xₖ) <= εₖ * max(tol_rel * norm(xₖ), tol_abs))
		# 	# Stagnation de l'itéré: ∥xk+1−xk∥ ≤ ε*max(tol_rel∥xk∥,tol_abs)
		# 	flag = 1
		# elseif (abs.(f(xₖ₊₁) - f(xₖ)) <= εₖ * max(tol_rel * abs.(f(xₖ)), tol_abs))
		# 	# Stagnation de la fonction: |f(xk+1)−f(xk)| ≤ ε*max(tol_rel|f(xk)|,tol_abs)
		# 	flag = 2
		elseif (k + 1 >= max_iter)
			# Nb d'itérations max
			flag = 3
		end

		# mise à jour des variables qu'on se trimballe
        λs = vcat(λs, λₖ₊₁)
        μs = vcat(μs, μₖ₊₁)
        εₖ = εₖ₊₁
        ηₖ = ηₖ₊₁
        xₖ = xₖ₊₁
    end

    x_sol = xₖ
    f_sol = f(x_sol)
    nb_iters = k

    return x_sol, f_sol, flag, nb_iters, μs, λs

end
