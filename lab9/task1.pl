tenant('Igor',      20, room(3)).
tenant('Natasha',   21, room(5)).
tenant('Alexandra', 20, room(4)).
tenant('Seva',      19, room(3)).
tenant('Yana',      21, room(10)).
tenant('UFO',       99, room(99)).


soft_compare(>, X, Y) :- X @>= Y.
soft_compare(<, X, Y) :- X @=< Y.
soft_compare(=, X, Y) :- X =@= Y.


by_name(Op, tenant(Name1, _, _), tenant(Name2, _, _)) :-
    soft_compare(Op, Name1, Name2).

by_age(Op, tenant(_, Age1, _), tenant(_, Age2, _)) :-
    soft_compare(Op, Age1, Age2).

by_age_then_name(>, Ten1, Ten2) :- by_age(>, Ten1, Ten2), !.
by_age_then_name(>, Ten1, Ten2) :- by_age(=, Ten1, Ten2), by_name(<, Ten1, Ten2), !.
by_age_then_name(<, _, _) :- by_age(<, _, _).


my_sort(Comparator, Sorted) :-
    findall(tenant(Name, Age, Room), tenant(Name, Age, Room), Source),
    predsort(Comparator, Source, Sorted), !.
