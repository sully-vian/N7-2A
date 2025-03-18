fact(0, Result) :- % Base case: 0! = 1
    Result is 1.
fact(N, Result) :- % Recursive case: N! = N * (N-1)!
    N > 0,
    N1 is N - 1,
    fact(N1, Result1),
    Result is N * Result1.
