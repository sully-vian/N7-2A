% Renvoie true si le graphe A possede la chaine c, false sinon
function possede = possedechaine(A, c)
    possede = true;
    for i = 1:length(c) - 1
        if A(c(i), c(i + 1)) == 0
            possede = false;
            break;
        end
    end
end
