filter(_, [], []).

filter(P, [X|Xs], [X|Out]) :-
    call(P, X), filter(P, Xs, Out), !.

filter(P, [_|Xs], Out) :-
    filter(P, Xs, Out), !.


% 1a) Предикат, выбирающий из исходного списка только четные числа.
is_even(Num) :- Num mod 2 =:= 0.

get_evens(List, Out) :-
    filter(is_even, List, Out).

% 1b) Предикат, выбирающий из исходного списка только отрицательные числа.
is_negative(Num) :- Num < 0.

get_negatives(List, Out) :-
    filter(is_negative, List, Out).

% 1c) Предикат, выбирающий из исходного списка только числа Фибоначчи.
is_fibonacci(Num) :-
    Num =:= 0; Num =:= 1;
    is_fibonacci(Num, 0, 1).

is_fibonacci(Num, F1, F2) :-
    FN is F1 + F2, (
        Num =:= FN;   Num > FN, is_fibonacci(Num, F2, FN)
    ).

get_fibonacci(List, Out) :-
    filter(is_fibonacci, List, Out).

% 1d) Предикат, выбирающий из исходного списка все элементы
%     (строки, атомы, списки и т. д.), кроме чисел.
non_integer(Term) :- not(integer(Term)).

get_non_integers(List, Out) :-
    filter(non_integer, List, Out).

% 1e) Выбриает из исходного списка только положительные числа, степени двойки.
is_power_of_2(Num) :-
    Num =:= 1;
    is_power_of_2(Num, 1).

is_power_of_2(Num, Value) :-
    NextVal is Value * 2, (
        Num =:= NextVal;  Num > NextVal, is_power_of_2(Num, NextVal)
    ).

get_powers_of_2(List, Out) :-
    filter(is_power_of_2, List, Out).
