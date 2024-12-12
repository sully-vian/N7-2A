function eulerien = isEulerien(A)
    degres = sum(A,1); %  vecteur des degrés
    sommets_pos = find(degres > 0); % vecteurs des sommets non isolés
    degres_pos = degres(sommets_pos); % vecteur des degrés sans les noeuds isolés
    parite_deg = mod(degres_pos, 2); % vecteur de 1 et 0

    if (sum(parite_deg) == 0) || (sum(parite_deg) == 2)
        % 2 ou 0 sommets de degré impair
        eulerien = true;
    else
        eulerien = false;
    end
end