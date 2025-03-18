% length of list
length([], Result) :-
    Result is 0.
length([_|T], Result) :-
    length(T, Result1),
    Result is Result1 + 1.
