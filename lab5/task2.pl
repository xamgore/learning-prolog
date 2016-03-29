map([], to([]), _).
map([A | ATail], to([C | CTail]), Mapper) :-
    call(Mapper, A, C), map(ATail, to(CTail), Mapper).

binary_map([], [], to([]), _).
binary_map([A | ATail], [B | BTail], to([C | CTail]), Mapper) :-
    call(Mapper, A, B, C), binary_map(ATail, BTail, to(CTail), Mapper).

aggregate_row([X], _, X) :- !.
aggregate_row([X | Row], Func, Res) :-
    aggregate_row(Row, Func, R), call(Func, R, X, Res).

% Предикат проверки на равенство двух матриц
equals([], []).
equals([Row | A], [Row | B]) :- equals(A, B).

% Предикат сложения двух матриц (если это возможно)
add_nums(A, B, C) :- C is A + B.
add_rows(A, B, C) :- binary_map(A, B, to(C), add_nums).
add(A, B, C)      :- binary_map(A, B, to(C), add_rows).

% Предикат вычитания одной матрицы из другой
sub_nums(A, B, C) :- C is A - B.
sub_rows(A, B, C) :- binary_map(A, B, to(C), sub_nums).
sub(A, B, C)      :- binary_map(A, B, to(C), sub_rows).

% Предикат проверки является ли матрица единичной
identity(Matrix) :- length(Matrix, Size), identity(Size, M), equals(M, Matrix).

zero_row(0, []) :- !.
zero_row(Size, [0 | Row]) :- S is Size - 1, zero_row(S, Row).

iden_row(Size, 0, Row)         :- zero_row(Size, Row), !.
iden_row(Size, 1, [1 | Row])   :- S is Size - 1, iden_row(S, 0, Row), !.
iden_row(Size, Pos, [0 | Row]) :- S is Size - 1, P is Pos - 1, iden_row(S, P, Row).

identity(Size, Matrix)            :- identity(Size, 1, Matrix).
identity(Size, Pos, [M | Matrix]) :- Pos =< Size, iden_row(Size, Pos, M), P is Pos + 1, identity(Size, P, Matrix), !.
identity(Size, P, [])             :- P is Size + 1.

% Предикат нахождения суммы элементов матрицы
sum_row([], 0).
sum_row([X | Row], Res)    :- sum_row(Row, R), Res is R + X.

sum_matr([], 0).
sum_matr([L | Lines], Res) :- sum_matr(Lines, R), sum_row(L, X), Res is R + X.

% Предикат нахождения максимального элемента матрицы
max(R, X, Res)     :- Res is max(R, X).
max_row(List, Res) :- aggregate_row(List, max, Res).

max_matr([L], Res)         :- max_row(L, Res), !.
max_matr([L | Lines], Res) :- max_matr(Lines, R), max_row(L, X), Res is max(R, X).

% Предикат нахождения количества отрицательных элементов в каждой строке. Результат — вектор
is_negative(X, Res) :- X < 0 -> Res is 1; Res is 0.

count_negatives_in_row(Row, Res) :- map(Row, to(Bools), is_negative), sum_row(Bools, Res).
count_negatives(Matrix, Res)     :- map(Matrix, to(Res), count_negatives_in_row).

% Предикат нахождения наибольшего элемента среди минимальных элементов каждой строки
min(R, X, Res) :- Res is min(R, X).

min_row(Row, Res)        :- aggregate_row(Row, min, Res).
max_in_mins(Matrix, Res) :- map(Matrix, to(Mins), min_row), max_row(Mins, Res).

% Предикат умножения матрицы на вектор
mult(by(Const), X, Res)          :- Res is X * Const.
scalar_mult(Vector, Num, Res)    :- map(Vector, to(Res), call(mult, by(Num))).
vector_mult(Matrix, Vector, Res) :- binary_map(Matrix, Vector, to(Res), scalar_mult).

% Предикат транспонирования матрицы
get_first([X | _], X).
remove_first([_ | Row], Row).

transpose([], []).
transpose([[] | Matrix], Res) :- transpose(Matrix, Res), !.
transpose(Matrix, [FirstElements | Transposed]) :-
    map(Matrix, to(FirstElements), get_first),
    map(Matrix, to(RestMatrix), remove_first),
    transpose(RestMatrix, Transposed).

% Предикат умножения двух матриц
