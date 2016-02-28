/*
Определить предикаты для вычисления следующих величин:
- максимум из двух чисел (трёхместный предикат);
- модуль числа X;
- гипотенуза прямоугольного треугольника, заданного длинами катетов;
- первая цифра в десятичной записи трехзначного натурального числа.
*/

max_of(X, Y, Res) :-
    (X >= Y, Res is X);
    (Res is Y).

modulo(X, Res) :-
    (X >= 0, Res is X);
    (X <  0, Res is -X).

hypotenuse(Cathetus1, Cathetus2, Res) :-
    Res is sqrt(Cathetus1 * Cathetus1 + Cathetus2 * Cathetus2).

first_digit(Num, Res) :-
    Res is Num div 100 mod 10.
