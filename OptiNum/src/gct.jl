using LinearAlgebra
"""
Approximation de la solution du problème

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real;
    max_iter::Integer = 100,
    tol_abs::Real = 1e-10,
    tol_rel::Real = 1e-8)

    s = zeros(length(g))

    j = 0
    g₀ = g
    s₀ = 0 * g
    p₀ = -g

    gⱼ = g₀
    sⱼ = s₀
    pⱼ = p₀

    # calculer les racines de ∥sⱼ+σpⱼ∥ = ∆
    function racines(sⱼ,pⱼ,Δ)
        # les coefs du polynome de degré 2 développé
        a = pⱼ' * pⱼ
        b = sⱼ'*pⱼ + pⱼ'*sⱼ
        c = sⱼ' * sⱼ - Δ^2

        discriminant = b^2 - 4 * a * c
        σₘᵢₙ = (-b - sqrt(discriminant)) / (2 * a)
        σₘₐₓ = (-b + sqrt(discriminant)) / (2 * a)
        return σₘᵢₙ, σₘₐₓ
    end

    while (j <= max_iter) && (norm(gⱼ) > max(norm(g₀)*tol_rel, tol_abs))

        q(s) = s' * gⱼ + 1/2 * s' * H * s

        κⱼ = pⱼ' * H * pⱼ

        if (κⱼ <= 0)
            # la racine de ∥sⱼ+σpⱼ∥ = ∆ pour laquelle q(sⱼ+σpⱼ) est la plus petite
            σₘᵢₙ, σₘₐₓ = racines(sⱼ,pⱼ,Δ)
            σⱼ = q(sⱼ + σₘᵢₙ*pⱼ) < q(sⱼ + σₘₐₓ*pⱼ) ? σₘᵢₙ : σₘₐₓ
            return sⱼ + σⱼ * pⱼ
        end

        αⱼ = gⱼ' * gⱼ / κⱼ
        if (norm(sⱼ + αⱼ * pⱼ) >= Δ)
            # la racine positive de ∥sⱼ+σpⱼ∥ = ∆
            _, σⱼ = racines(sⱼ,pⱼ,Δ)
            return sⱼ + σⱼ * pⱼ
        end

        # itération
        sⱼ₊₁ = sⱼ + αⱼ * pⱼ
        gⱼ₊₁ = gⱼ + αⱼ * H * pⱼ
        βⱼ = (gⱼ₊₁' * gⱼ₊₁) / (gⱼ' * gⱼ)
        pⱼ₊₁ = -gⱼ₊₁ + βⱼ * pⱼ
        j = j + 1

        sⱼ = sⱼ₊₁
        gⱼ = gⱼ₊₁
        pⱼ = pⱼ₊₁
    end

   return sⱼ
end
