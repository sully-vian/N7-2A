using LinearAlgebra
"""
Approximation de la solution du problème

	min qₖ(s) = s'gₖ + 1/2 s' Hₖ s

		sous les contraintes s = -t gₖ, t > 0, ‖s‖ ≤ Δₖ

# Syntaxe

	s = cauchy(g, H, Δ; kwargs...)

# Entrées

	- gₖ : (Vector{<:Real}) le vecteur gₖ
	- Hₖ : (Matrix{<:Real}) la matrice Hₖ
	- Δₖ : (Real) le scalaire Δₖ
	- kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
		• tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)

# Sorties

	- s : (Vector{<:Real}) la solution du problème

# Exemple d'appel

	g = [0; 0]
	H = [7 0 ; 0 2]
	Δ = 1
	s = cauchy(g, H, Δ)

"""
function cauchy(gₖ::Vector{<:Real}, Hₖ::Union{Matrix{<:Real}, UniformScaling{Bool}}, Δₖ::Real;
	tol_abs::Real = 1e-10)
	s = 0 * gₖ

	if (norm(gₖ) <= tol_abs)
		return s
	end

	a = gₖ' * Hₖ * gₖ
	b = -norm(gₖ)^2
	# c = f(xₖ) # pas nécessaire
	# φₖ(t) = 1/2*at² + bt + c

	# Calcul du min de φₖ (facile car trinôme du 2nd degré)
	if (a <= 0)
		tₘᵢₙ = Δₖ / norm(gₖ)
	else
		tₘᵢₙ = min(-b / a, Δₖ / norm(gₖ))
	end

	s = -tₘᵢₙ * gₖ
	return s
end
