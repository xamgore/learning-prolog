?- dynamic(client_mobile/4).

client_mobile(ivanova,'89284543344',super,[44,34,23,56,12,7,22]).
client_mobile(dumin,'89194543322',light,[12,4,3,6,12]).
client_mobile(perova,'89284111122',super,[112,314,213,56,12]).
client_mobile(kapivanov,'8950883322',light,[5,1,1,2,4]).
client_mobile(businova,'8966773322',light,[5,5,5,5,2]).
client_mobile(mariyna,'89211093322',super,[43,64,13,5,22]).
client_mobile(dedov,'8934566322',superr,[42,334,123,156,112]).
client_mobile(test, '12345', kekRate, [1, 2, 3]).

out_all() :-
    client_mobile(S, N, R, L), writef('%10L%12L%8C %w\n', [S, N, R, L]), fail.
out_all().

find_surname_of_rate(Rate, List_surname) :-
    findall(S, client_mobile(S, _, Rate, _), List_surname).

add_client() :-
    write('Enter surname'), read(S),
    write('Enter number'), read(N),
	write('Enter rate'), read(R),
	write('Enter list_duration_talk_on_phone'), read(L),
	assertz(client_mobile(S, N, R, L)).

change_rate_client(Surname, NewRate) :-
	retract(client_mobile(Surname, N, _, L)),
	assertz(client_mobile(Surname, N, NewRate, L)), !.
change_rate_client(_, _) :- write('Client does not exists!\n'), fail.

change_rate_client_all() :-
    forall( client_mobile(Surname, _, _, _),
        (format('Enter new rate for ~s: ', [Surname]), read(NewRate),
         change_rate_client(Surname, NewRate)) ).


% Меняет номер телефона указанного клиента
change_phone(Surname, NewPhone) :-
    retract(client_mobile(Surname, _, Rate, List)),
    assertz(client_mobile(Surname, NewPhone, Rate, List)), !.
change_phone(_, _) :- write('Client does not exists!\n'), fail.

% Вычисляет среднее время разговоров каждого клиента
avg_time() :-
    forall((
            client_mobile(Surname, _, _, List),
            sum_list(List, Sum), length(List, Length),
            AvgTime is Sum / Length
        ), writef('%13R: %w\n', [Surname, AvgTime]) ).

% Находит всех "разговорчивых" клиентов (параметр указывается пользователем)
find_talkative() :- find_talkative(127).
find_talkative(Threshold) :-
    forall((
        client_mobile(Surname, _, _, List),
        sum_list(List, Sum), Sum > Threshold
    ), writef('%13R: %w\n', [Surname, Sum]) ).

% Удаляет всех молчаливых клиентов
remove_inactive() :- remove_inactive(127).
remove_inactive(Threshold) :-
    forall((
        client_mobile(Surname, _, _, List),
        sum_list(List, Sum), Sum < Threshold
    ), retract(client_mobile(Surname, _, _, _)) ).
