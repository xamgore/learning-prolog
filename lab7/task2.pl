:- use_module(library(apply)).
?- dynamic(student/4). dynamic(teacher/4).

% Создать базу данных на успеваемость студентов университета
% и базу преподавателей (с читаемыми курсами).
student(igor,     3, 9, [[5, 5, 5, 4], [4, 4, 4, 5]]).
student(natali,   3, 9, [[5, 4, 5, 3], [5, 5, 5, 5]]).
student(alexadra, 3, 9, [[5, 5, 5, 5], [5, 5, 5, 5]]).
student(bad_guy,  2, 8, [[2, 2, 2, 2]]).

discipline(fuzzy_logic, [skorohodov], [(3, 9)]).
discipline(prolog, [jachmeneva], [(3, 9), (3, 8)]).
discipline(prolog, [another_teacher], []).
discipline(computation_theory, [bravit], [(2, _)]).

out_all() :-
    student(S, Grd, Grp, M), writef('%10L%w.%w %w\n', [S, Grd, Grp, M]), fail.
out_all().


% a. Выдает список студентов по ключу (номер группы, фамилия, др)
students(List) :- findall(Name, student(Name, _, _, _), List).

% b. Выдает список неуспевающих студентов
is_looser((_, AvgRate)) :- AvgRate =< 2.
loosers(List) :- filter_by_rating(is_looser, List).

% c. Выдает список студентов – отличников
is_good_guy((_, AvgRate)) :- AvgRate == 5.
the_best(List) :- filter_by_rating(is_good_guy, List).

% d. Вычисляет средний балл студентов
avg_rates(Students) :-
    findall( (Name, Avg), (
            student(Name, _, _, Rates), flatten(Rates, Flat),
            sum_list(Flat, Sum), length(Flat, Length), Avg is Sum / Length
        ), Students).

% e. Выдает список студентов, средний балл которых, удовлетворяет заданному ключу
filter_by_rating(Predicate, List) :- avg_rates(R), include(Predicate, R, List).

% f. Добавляет в список оценок результат последней сессии
add_marks(Name, NewMarks) :-
    retract(student(Name, Grade, Group, OldMarks)),
    append([OldMarks, NewMarks], Marks),
    assertz(student(Name, Grade, Group, Marks)).

% g. Удаляет из базы неуспевающих студентов
remove_student((Name, _)) :- retract(student(Name, _, _, _)).
remove_loosers() :- loosers(List), maplist(remove_student, List).

% h. Выдает читаемые курсы для определенного курса
get_disciplines_for(Grade, Group) :-
    forall(( discipline(Name, _, Groups), member((Grade, Group), Groups) ),
        format('~s\n', Name)).

% i. Выдает списки преподавателей курса
get_teachers_of(Discipline) :-
    forall( discipline(Discipline, Teachers, _), format('~w\n', [Teachers]) ).

% j. Выдает списки студентов, посещающих данный курс
write_students_in((Grade, Group)) :-
    forall( student(Name, Grade, Group, _), writeln(Name) ).

get_students_of(Discipline) :-
    findall(Groups, discipline(Discipline, _, Groups), List),
    flatten(List, Flat), list_to_set(Flat, Set),
    maplist(write_students_in, Set).
