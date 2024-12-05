using LinearAlgebra
include("./cauchy.jl")
include("./gct.jl")
"""
Approximation de la solution du problème min f(x), x ∈ Rⁿ.

L'algorithme des régions de confiance résout à chaque itération, un modèle quadratique
de la fonction f dans une boule (appelée la région de confiance) de centre l'itéré 
courant. Cette minimisation se fait soit par un pas de Cauchy ou par l'algorithme 
du gradient conjugué tronqué.

# Syntaxe

	x_sol, f_sol, flag, nb_iters, xs = regions_de_confiance(f, gradf, hessf, x0; kwargs...)

# Entrées

	- f       : (Function) la fonction à minimiser
	- gradf   : (Function) le gradient de la fonction f
	- hessf   : (Function) la hessienne de la fonction f
	- x0      : (Vector{<:Real}) itéré initial
	- kwargs  : les options sous formes d'arguments "keywords"
		• max_iter      : (Integer) le nombre maximal d'iterations (optionnel, par défaut 5000)
		• tol_abs       : (Real) la tolérence absolue (optionnel, par défaut 1e-10)
		• tol_rel       : (Real) la tolérence relative (optionnel, par défaut 1e-8)
		• epsilon       : (Real) le epsilon pour les tests de stagnation (optionnel, par défaut 1)
		• Δ0            : (Real) le rayon initial de la région de confiance (optionnel, par défaut 2)
		• Δmax          : (Real) le rayon maximal de la région de confiance (optionnel, par défaut 10)
		• γ1, γ2        : (Real) les facteurs de mise à jour de la région de confiance (optionnel, par défaut 0.5 et 2)
		• η1, η2        : (Real) les seuils pour la mise à jour de la région de confiance (optionnel, par défaut 0.25 et 0.75)
		• algo_pas      : (String) l'algorithme de calcul du pas - "cauchy" ou "gct" (optionnel, par défaut "gct")
		• max_iter_gct  : (Integer) le nombre maximal d'iterations du GCT (optionnel, par défaut 2*length(x0))

# Sorties

	- x_sol : (Vector{<:Real}) une approximation de la solution du problème
	- f_sol : (Real) f(x_sol)
	- flag  : (Integer) indique le critère sur lequel le programme s'est arrêté
		• 0  : convergence
		• 1  : stagnation du xk
		• 2  : stagnation du f
		• 3  : nombre maximal d'itération dépassé
	- nb_iters : (Integer) le nombre d'itérations faites par le programme
	- xs    : (Vector{Vector{<:Real}}) les itérés

# Exemple d'appel

	f(x) = 100 * (x[2] - x[1]^2)^2 + (1 - x[1])^2
	gradf(x) = [-400*x[1]*(x[2]-x[1]^2) - 2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
	hessf(x) = [-400*(x[2]-3*x[1]^2)+2  -400*x[1] ; -400*x[1]  200]
	x0 = [1; 0]
	x_sol, f_sol, flag, nb_iters, xs = regions_de_confiance(f, gradf, hessf, x0, algo_pas="gct")

"""
function regions_de_confiance(f::Function, gradf::Function, hessf::Function, x0::Vector{<:Real};
	max_iter::Integer = 5000, tol_abs::Real = 1e-10, tol_rel::Real = 1e-8, epsilon::Real = 1,
	Δ0::Real = 2, Δmax::Real = 10, γ1::Real = 0.5, γ2::Real = 2, η1::Real = 0.25, η2::Real = 0.75,
	algo_pas::String = "gct", max_iter_gct::Integer = 2 * length(x0))

	#
	x_sol = x0
	f_sol = f(x_sol)
	flag = -1
	nb_iters = 0
	xs = [x0] # vous pouvez faire xs = vcat(xs, [xk]) pour concaténer les valeurs
	xₖ = xs[end]

	Hₖ = hessf(xₖ)
	gₖ = gradf(xₖ)
	Δ = [Δ0]
	Δₖ = Δ[end]

	# vérifier CN1 dès le début
	if (norm(gradf(x0)) <= max(tol_rel * norm(gradf(x0)), tol_abs))
		flag = 0
	end

	while (flag == -1)
		xₖ = xs[end]

		Hₖ = hessf(xₖ)
		gₖ = gradf(xₖ)

		if (algo_pas == "cauchy")
			sₖ = cauchy(gₖ, Hₖ, Δₖ, tol_abs=tol_abs)
		elseif (algo_pas == "gct")
			sₖ = 0 # TODO
		else
			error("Pas d'algo portant le nom \"" * algo_pas * "\", les seuls choix possibles sont \"cauchy\" et \"gct\".")
		end

		mₖ0 = f(xₖ)
		mₖsₖ = f(xₖ) + (gₖ' * sₖ) + (1 / 2 * sₖ' * Hₖ * sₖ)

		ρₖ = (f(xₖ) - f(xₖ + sₖ)) / (mₖ0 - mₖsₖ)

		# mise-à-jour (ou non) de l'itéré
		if (ρₖ >= η1)
			xₖ₊₁ = xₖ + sₖ
		else
			xₖ₊₁ = xₖ
		end

		if (ρₖ >= η2)
			# augmentation de la région de confiance
			Δₖ₊₁ = min(γ2 * Δₖ, Δmax)
		elseif (ρₖ <= η1)
			# diminution de la région de confiance
			Δₖ₊₁ = γ1 * Δₖ
		else
			# on ne touche pas la région de confiance
			Δₖ₊₁ = Δₖ
		end
		nb_iters += 1

		if (norm(gradf(xₖ₊₁)) <= max(tol_rel * norm(gradf(x0)), tol_abs))
			# CN1: ∥∇f(xk+1)∥ ≤ max(tol_rel*∥∇f(x0)∥, tol_abs)
			flag = 0
		elseif (ρₖ >= η1) && (norm(xₖ₊₁ - xₖ) <= epsilon * max(tol_rel * norm(xₖ), tol_abs))
			# vérifier seulement si l'itéré a été mis à jour
			# Stagnation de l'itéré: ∥xk+1−xk∥ ≤ ε*max(tol_rel∥xk∥,tol_abs)
			flag = 1
		elseif (ρₖ >= η1) && (abs(f(xₖ₊₁) - f(xₖ)) <= epsilon * max(tol_rel * abs(f(xₖ)), tol_abs))
			# Stagnation de la fonction: |f(xk+1)−f(xk)| ≤ ε*max(tol_rel|f(xk)|,tol_abs)
			flag = 2
		elseif (nb_iters >= max_iter)
			# Nb d'itérations max
			flag = 3
		end

		# mise à jur des variables qu'on se trimballe
		Δₖ = Δₖ₊₁
		xs = vcat(xs, [xₖ₊₁])

	end

	x_sol = xs[end]
	f_sol = f(x_sol)

	return x_sol, f_sol, flag, nb_iters, xs
end
