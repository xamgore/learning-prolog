%matrix_str(3,3,[[1,2,3,4],[1,2,3,4],[1,2,3,4]]).
%matrix_str(4,4,[[1,2,3,4,1],[5,6,7,8,1],[9,10,13,1,31],[2,2,3,1,2]]).
matrix_str(3, 3, [[1, 2, 3, -3], [2, 1, 1, 1], [-1, 2, 2, -3]]).
matrix_str(3, 3, [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 13, 31]]).
matrix_str(3, 3, [[1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3]]).

%%% output matrix
print_matr([]) :- nl, !.
print_matr([A | L]) :-
	print_str(A), nl,
	print_matr(L).

print_str([]).
print_str([A | L]) :-
	write(A), write('  '),
	print_str(L).

%%% mult str on number
mult_str([X], D, [Y]) :- Y is X * D.
mult_str([X | L], D, [Y | L1]) :-
    Y is X * D,
    mult_str(L, D, L1).

%%% mult matr on number
mult([X], D, [Y]) :-
    mult_str(X, D, Y).

mult([X | L], D, [Y | LL]) :-
    mult_str(X, D, Y),
    mult(L, D, LL).
