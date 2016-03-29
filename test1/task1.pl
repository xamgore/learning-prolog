% Стребежев Игорь, Вариант 1

% 1. Написать предикат нахождения суммы N слагаемых ряда.
power(X, 0, 1) :- !.
power(X, N, Res) :-
    Nk is N - 1, power(X, Nk, R), Res is R * X.

sums(0, 1) :- !.
sums(N, Res) :-
    Nk is N - 1, sums(Nk, R),

    power(-1, N, Min1), power(X, N, XN), power(4, N, FN),
    Res is Min1 * XN / FN.

% 2. Дан числовой список. Написать предикат нахождения среднего
%    значения среди отрицательных кратных 3.
%
% ?- mean_value([1, 2, 3, -1, 0, -3], R).
% R = -3.

mean_value(Row, Res) :-
    filter(Row, Negatives, is_negative),
    filter(Negatives, List, call(is_dividable, by(3)) ),
    sum(List, Sum), len(List, Len),
    (Len == 0 -> Res is 0; Res is Sum / Len), !.

filter([], [], _) :- !.
filter([X | Xs], [X | Row], Filter) :- call(Filter, X), filter(Xs, Row, Filter).
filter([_ | Xs], Row, Filter)       :- filter(Xs, Row, Filter).

is_negative(X)         :- X < 0.
is_dividable(by(X), Y) :- Y mod X =:= 0.

len([], 0)         :- !.
len([_ | Xs], Res) :- len(Xs, R), Res is R + 1.

sum([], 0)         :- !.
sum([X | Xs], Res) :- sum(Xs, R), Res is R + X.

% 3. Дан список арифметического выражения (элементами являются числа и знаки
%    операций). Написать предикат вычисления выражения, считая все операции
%    одинакового приоритета. Так, список [3,+,5,-,1,/,2] даст значение 3.5.
%    Если элементами списка являются списки, то вычислять эти выражения,
%    заключенные в скобки.
%
% ?- eval([2, *, [1, +, 2]], R).
% R = 6.

+(A, B, R) :- R is A + B.
-(A, B, R) :- R is A - B.
*(A, B, R) :- R is A * B.
/(A, B, R) :- R is A / B.

eval([X], Res) :- (is_list(X) -> eval(X, Res); Res is X), !.

eval([X, Op, Y | Args], Res) :-
    (is_list(Y) -> eval(Y, YVal); YVal is Y),
    member(Op, [+, -, *, /]), call(Op, X, YVal, R),
    eval([R | Args], Res), !.


% 4. Дана база знаний о странах мира. Написать предикат нахождения стран
%    с населением, большим заданного А (млн. людей), и имеющий указанный климат.
%    Если нет подходящих стран, вывести сообщение. Обратите внимание, что
%    население указано в разных единицах измерения, т.е. необходимо
%    преобразование в требуемые единицы.
find_country(Amount, Climate, Name) :-
    страна(Name, _, Count, Unit, Climate, _),
        value(Count, Unit, Val),
        Val > Amount * 1 000 000.

find_all_countries(Amount, Climate) :-
    find_country(Amount, Climate, _) ->
        forall( find_country(Amount, Climate, Name), format('~s\n', [ Name ]) );
        write('Not found').

%страна(название, столица, население, единицы_измерения_населения,климат,число_соседей).
страна(россия,москва,145,млн,умеренный,15).
страна(украина,киев,35,млн,умеренный,4).
страна(польша,варшава,0.03,млрд,умеренный,6).
страна(мексика,мехико,340000,тыс,тропический,2).
страна(бразилия,рио,0.1,млрд,субтропический,5).
страна(австралия,сидней,4500,тыс,умеренный,0).
страна(египет,каир,45,млн,тропический,10).
страна(германия,берлин,50,млн,умеренный,11).
страна(китай,пекин,1.5,млрд,умеренный,20).
страна(индия,дели,1,млрд,тропический,7).

value(X, тыс, R)  :- R is X * 1 000.
value(X, млн, R)  :- R is X * 1 000 000.
value(X, млрд, R) :- R is X * 1 000 000 000.


% 5. Дана квадратная матрица — список списков строк. Найти максимальный четный
%    отрицательный элемент. Или выдать сообщение об отсутствии такового.
%
% ?- find_max_even_negative_element([[1, 2, 3], [-1, -2]], R).
% R = -2.
%
% ?- find_max_even_negative_element([[1, 2, 3], [-1, 0]], R).
% Элемента не существует
% false.

flow([], [])                           :- !.
flow([[] | Matrix], Res)               :- flow(Matrix, Res), !.
flow([[ A | Row] | Matrix], [A | Res]) :- flow([Row | Matrix], Res), !.
flow(X, X).

max([X], X) :- !.
max([X | Row], Res) :- max(Row, R), Res is max(X, R).

even(X) :- X mod 2 =:= 0.

find_max_even_negative_element(Matrix, Res) :-
    flow(Matrix, List),
    filter(List, Negatives, is_negative),
    filter(Negatives, Evens, even),
    max(Evens, Res), !;

    write('Элемента не существует'), fail.

% 6. Дан список произвольных элементов, в том числе и списков. Сформировать
%    из него список элементов без вложенной списковой структуры
%    ([45, [2, [67], атом,12],11] ПРЕОБРАЗУЕТСЯ В список [45,2,67, атом,12,11]).
%    [Или 6 баллов,] если в списке не будет повторяющихся элементов.
%
% ?- plain([[[ 3 ]], [[[4]]], [[1, 2], [4, 5]] ], R).
% R = [3, 4, 1, 2, 4, 5].
% ?- plain([45, [2, [67], атом,12],11], R).
% R = [45, 2, 67, атом, 12, 11].
plain([], []) :- !.
plain([X | Row], Plain) :-
    is_list(X), flow(X, R), append(R, Row, List), plain(List, Plain), !.
plain([X | Row], [X | Plain]) :-
    plain(Row, Plain).
