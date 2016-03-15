get_last(List, Elem, Num) :- get_last(List, Elem, 0, Num).

get_last([      ],    _,      _,  -1) :- !.
get_last([X | Xs], Elem, Length, Num) :-
    get_last(Xs, Elem, Length + 1, Next),
    Next =\= -1    -> Num is Next;
    X    =:= Elem  -> Num is Length;
    Num is -1.

min_elem([X], X) :- !.
min_elem([H | List], Result) :-
    min_elem(List, Min),
    (H =< Min -> Result is H; Result is Min).

% 1. Предикат нахождения номера последнего минимального элемента числового списка.
get_last_min(List, Num) :-
    min_elem(List, Elem), get_last(List, Elem, Num).

% 2. Предикат нахождения количества отрицательных элементов числового списка.
count_negatives([   ], 0)   :- !.
count_negatives([H|T], Res) :-
    count_negatives(T, Count),
    (H < 0 -> Res is Count + 1; Res is Count).

% 3. Предикат нахождения произведения двузначных чисел числового списка.
get_two_digit_nums([], []).

get_two_digit_nums([X | Tail], [X | Out]) :-
    between(10, 99, X),
    get_two_digit_nums(Tail, Out), !.

get_two_digit_nums([_ | Tail], Out) :-
    get_two_digit_nums(Tail, Out), !.

product([], 0)  :- !.
product([X], X) :- !.
product([X | Tail], Result) :-
    product(Tail, Product), Result is Product * X.

product_of_two_digit_nums(List, Product) :-
    get_two_digit_nums(List, Nums), product(Nums, Product).

% 4. Предикат удаления первого вхождения указанного элемента.
remove_first([], _, [])              :- !.
remove_first([X | Tail], X, Tail)    :- !.
remove_first([X | Tail], Elem, [X | Out]) :-
    X =\= Elem, remove_first(Tail, Elem, Out).

% 5. Предикат удаления всех вхождений указанного элемента.
remove_all([], _, []) :- !.
remove_all([X | Tail], X, Out) :-
    remove_all(Tail, X, Out), !.
remove_all([X | Tail], Elem, [X | Out]) :-
    remove_all(Tail, Elem, Out), !.

% 6. Предикат дублирования всех четных элементов числового списка.
double_evens([], [])   :- !.
double_evens([X], [X]) :- !.
double_evens([X, Y | Tail], [X, Y, Y | Out]) :-
    double_evens(Tail, Out).

% 7. Предикат нахождения максимального
%    среди отрицательных элементов числового списка.
get_negatives([], []).
get_negatives([X|Xs], [X|Out])  :-  X < 0, get_negatives(Xs, Out), !.
get_negatives([_|Xs], Out)      :-         get_negatives(Xs, Out), !.

min_of_negatives(List, Min) :-
    get_negatives(List, Negs),
    min_elem(Negs, Min).
