% Определить предикаты для вычисления следующих величин (N натуральное число):

% сумма чисел от 1 до N
sum_n(1, 1).
sum_n(N, Res) :-
    Nminus1 is N - 1,
    sum_n(Nminus1, Sum),
    Res is Sum + N.

% факториал числа N
factorial(1, 1).
factorial(N, Res) :-
    Nminus1 is N - 1,
    factorial(Nminus1, Prod),
    Res is Prod * N.

% сумма квадратов чисел от 1 до N
sum_n_squares(1, 1).
sum_n_squares(N, Res) :-
    Nminus1 is N - 1,
    sum_n_squares(Nminus1, Sum),
    Res is Sum + N * N.

% X в степени N
power(X, N, Res) :-
    (N =:= 1) ->
        Res is X;
        power(X, N - 1, Pow), Res is X * Pow.

% сумма нечётных чисел от 1 до N
sum_odds(0, 0) :- !.
sum_odds(1, 1) :- !.
sum_odds(N, Sum) :-
    N mod 2 =:= 0
        -> K is N - 1, sum_odds(K, Res), Sum is Res
        ;  K is N - 2, sum_odds(K, Res), Sum is Res + N.

% количество чётных чисел на заданном интервале
count_evens_at_interval(Start, End, Count) :-
    (Start mod 2 =\= 0, End mod 2 =\= 0)
        -> Count is (End - Start) // 2
        ;  Count is (End - Start) // 2 + 1.

% сумма цифр заданного числа
sum_digits(Num, Sum) :-
    Num =:= 0
        -> Sum is 0
        ;  sum_digits(Num div 10, Res), Sum is Num mod 10 + Res.

% произведение цифр заданного числа
product_digits(Num, Pr) :-
    Num =:= 1
        -> Pr is 1
        ;  product_digits(Num div 10, Res),
           Pr is Num mod 10 * Res.

% генерации чисел для треугольника Паскаля
% C_n^k = C_n-1^k + C_n-1^k-1

pascal(N, K, 0) :- K > N, !.
pascal(N, K, 1) :- (N =< 0; K =< 0), !.
pascal(N, K, R) :-
    Np is N - 1, Kp is K - 1,
    pascal(Np, Kp, R1),
    pascal(Np, K,  R2),
    R is R1 + R2.

% сумма первых N слагаемых гармонического ряда или ряда Лейбница
% sum(N) = 1/N + sum(N - 1)
harmonic(1, 1) :- !.
harmonic(N, R) :-
    Np is N - 1,
    harmonic(Np, S),
    R is 1 / N + S.
