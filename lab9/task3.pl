% Расширьте определение предиката больше (или меньше) для сортировки списка,
% состоящего не только из чисел, но и атомов, строк, определив правила
% их упорядочивания самостоятельно.

less(N, X) :- integer(N), integer(X), N < X.
less(N, A) :- integer(N), atom(A).
less(N, S) :- integer(N), string(S).

less(S, A) :- string(S), atom(A).
less(S, T) :- string(S), string(T), S @< T.

less(A, X) :- atom_string(A, S), less(S, X).
