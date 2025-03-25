% on indique que les faits concernant smart/1 évoluent
:- dynamic(smart/1).

% on étabit quelques faits
smart(christophe).
smart(guillaume).
smart(aurelie).

% on définit watch/2 sur les deux cas
watch(X, college_de_france) :-
    % regarder collège de france -> smart
    assertz(smart(X)).
watch(X, tiktok) :-
    % regarder tiktok -> not smart
    retract(smart(X)).
