% Tenants
tenant('Igor',      20, room(3)).
tenant('Natasha',   21, room(5)).
tenant('Alexandra', 20, room(4)).
tenant('Seva',      19, room(3)).
tenant('Yana',      21, room(10)).
tenant('UFO',       99, room(99)).


max([X],     X)   :- !.
max([X | L], Max) :- max(L, R), Max is max(X, R).

sum([],      0) :- !.
sum([X | Y], R) :- sum(Y, P), R is X + P.

avg(List, R) :- length(List, L), sum(List, S), R is S / L.

% 1. Написать предикат, который находит объекты с наибольшим параметром.
find_max_age(R) :-
    findall(Age,  tenant(_, Age, _), Ages), max(Ages, Max),
    findall(Name, tenant(Name, Max, _), R).

% 2. Написать предикат, который находит объекты, чей параметр выше средней
%    по всем объектам (средняя арифметическая) и их количество.
find_above_avg(R, Count) :-
    findall(Age,    tenant(_, Age, _), Ages), avg(Ages, Avg),
    findall(Name, ( tenant(Name, Age, _), Age >= Avg ), R),
    length(R, Count).
