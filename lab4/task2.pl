map(_, [], []).

map(Rule, [X|Xs], [Y|Ys]) :-
    call(Rule, X, Y),
    map(Rule, Xs, Ys).

% 1. Предикат, который удваивает все элементы исходного числового списка.
twice(X, Y) :- Y is X * 2.

get_twiced(List, Out) :- map(twice, List, Out).

% 2. Предикат, который  все отрицательные элементы исходного числового
%    списка преобразует в положительные, нулевые оставляет без изменений,
%    а положительные числа возводит в квадрат.
task2_rule(Num, Res) :-
    Num < 0 -> Res is -Num;
    Num > 0 -> Res is Num * Num;
    Num = 0 -> Res is 0.

get_mapped_by_task2(List, Out) :- map(task2_rule, List, Out).

% 3. Предикат, который все элементы (целые положительные) исходного числового
% списка воспринимает как степени 2. Список [3,6,2,10] даст список [8,64,4,1024].
pow2(Num, Res) :- pow(2, Num, Res).

get_powered(List, Out) :- map(pow2, List, Out).

% 4. Предикат, который создает список длин элементов исходного списка.
% Отдельный несписковый элемент даст число 0.
% Список [4,[5,6,1],[32], 67, [7,8,89,8]] сформирует список [0,3,1,0,4].
length_of([X|Xs], Res) :-
    length_of(Xs, Length),
    Res is Length + 1.
length_of(_, 0) :- !.

get_lengths(List, Out) :- map(length_of, List, Out).
