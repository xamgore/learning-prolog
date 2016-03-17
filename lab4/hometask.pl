% 1. Построить список L3 состоящий из тех и только тех элементов списка L1,
%    которые не входят в список L2.
diff([], _, []) :- !.

diff([X | Source], Deprecated, Result) :-
    member(X, Deprecated),
    diff(Source, Deprecated, Result), !.

diff([X | Source], Deprecated, [X | Result]) :-
    diff(Source, Deprecated, Result).


% 2. Построить список L3 состоящий из тех и только тех элементов списка L1,
%    которые входят и в список L2.
intersect([], _, []) :- !.
intersect(_, [], []) :- !.

intersect([X | Source], Required, [X | Result]) :-
    member(X, Required),
    intersect(Source, Required, Result), !.

intersect([_ | Source], Required, Result) :-
    intersect(Source, Required, Result).


% 3. Построить список L2 состоящий из элементов списка L1,
%    которые входят однократно в список L1.
singletons(List, Out) :- singletons(List, [], Out).

singletons([], _, []) :- !.

singletons([X | List], Passed, [X | Out]) :-
    not(member(X, List)),
    not(member(X, Passed)),
    singletons(List, [X | Passed], Out), !.

singletons([X | List], Passed, Out) :-
    singletons(List, [X | Passed], Out).


% 4. Построить список L2 состоящий из элементов списка L1,
%    которые входят K-раз в список L1
count([], _, 0) :- !.

count([X | List], X, Res) :-
    count(List, X, Count),
    Res is Count + 1, !.

count([_ | List], X, Res) :-
    count(List, X, Res).


k_tones(List, K, Out) :- k_tones(List, K, [], Out).

k_tones([], _, _, []) :- !.

k_tones([X | List], K, Passed, [X | Out]) :-
    not(member(X, Passed)),
    count([X | List], X, Count), Count == K,
    k_tones(List, K, [X | Passed], Out), !.

k_tones([X | List], K, Passed, Out) :-
    k_tones(List, K, [X | Passed], Out).

% 5. Выяснить, является ли третий список склейкой первого и второго.
concatenate([], List, List) :- !.
concatenate([X | List], In, [X | Result]) :-
    concatenate(List, In, Result).

% 6. Дан список L1, элементами которого могут быть списки чисел,
%    например [[2,3,4],[5,3,2,3],[67,55]]. Построить список L2,
%    элементами которого только числовые элементы списка L1,
%    например [2,3,4,5,3,2,3,67,55].
flow([], []) :- !.
flow([[] | Arrays], Out) :-
    flow(Arrays, Out), !.
flow([[ X | Y ] | Arrays], [X | Out]) :-
    flow([Y | Arrays], Out).
