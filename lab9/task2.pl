% Упорядочить исходный числовой список.
quick_sort([], []).
quick_sort([H | Tail], Sorted):-
	pivoting(H, Tail, L1, L2),
	quick_sort(L1, Sorted1),
	quick_sort(L2, Sorted2),
	append(Sorted1, [H | Sorted2]).

pivoting(_, [], [], []).
pivoting(B, [X | Source], [X | Left], Right) :-
	X =< B, pivoting(B, Source, Left, Right).
pivoting(B, [X | Source], Left, [X | Right]) :-
	X  > B, pivoting(B, Source, Left, Right).
