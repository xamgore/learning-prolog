% Tenants
tenant('Igor',      20, room(3)).
tenant('Natasha',   21, room(5)).
tenant('Alexandra', 20, room(4)).
tenant('Seva',      19, room(3)).
tenant('Yana',      21, room(10)).
tenant('UFO',       99, room(99)).

flat(room(3), 25).
flat(room(4), 100).
flat(room(5), 75).
flat(room(10), 0).
flat(room(99), 99).

% 1.a  Вывести самых молодых жильцов дома (возраст< 25)
%      и номера квартир, в которых они живут.
the_youngest(R) :-
    findall((Name, Room), ( tenant(Name, Age, Room), Age < 25 ), R).

% 1.b  Вывести всех жильцов с площадью квартиры больше 50 кв.м.
the_wealthiest(R) :-
    findall(Name, ( tenant(Name, _, Room), flat(Room, Square), Square > 50 ), R).


% Employees

filter(_, [], []).
filter(P, [X|Xs], [X|Out]) :- call(P, X), filter(P, Xs, Out), !.
filter(P, [_|Xs], Out) :- filter(P, Xs, Out), !.

% 3.a  Найти сотрудников на должности "директор", чей возраст меньше 40 лет.
young_director(employee(_, Age, 'Director', _)) :- Age < 40.

find_young_directors(R) :-
    read_file_to_terms('employees.pl', Emps, []),
    filter(young_director, Emps, R).

% 3.b  Вывести фамилии сотрудников предприятия и их оклады,
%      оклады которых меньше 10000
small_salary(employee(_, _, _, S)) :- S =< 10000.

find_poor_employees(R) :-
    read_file_to_terms('employees.pl', Emps, []),
    filter(small_salary, Emps, R).
