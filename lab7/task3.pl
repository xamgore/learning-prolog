% Cоздайте БД клиентов банка.
?- dynamic(client/4).

client(igor, 0, rub, 0).

% a. добавить клиента с открытием счета
add_client(Name, Type) :-
    (Type = rub; Type = euro),
    remove_client(Name),
    assertz(Name, 0, Type, 0).

% б. положить/снять некоторую сумму определенным клиентом (для снятия - пароль! и разрешить брать в долг, но не больше некоторого МАХ)
edit_money(Name, Value) :-
    retract(Name, _, Type, Percent),
    assertz(Name, Value, Type, Percent).

take_money(Name, Amount) :-
    client(Name, Value, _, _),
    NewVal is Value + Amount,
    (NewVal < 20, fail);
    edit_money(Name, NewVal).

% в. закрыть счет
remove_client(Name) :- retract(Name, _, _, _).

% г. произвести пересчет суммы вклада согласно процентной ставки
add_by_percent(Name) :-
    client(Name, Value, _, Percent),
    NewVal is Value * Percent + Value,
    edit_money(Name, NewVal).

% д. изменение процентной ставки
change_percent(Name, Percent) :-
    retract(Name, Val, Type, _),
    assertz(Name, Val, Type, Percent).

% е. получить всех клиентов с наименьшей процентной ставкой
lowest_percent(Res) :-
    findall(Percent, client(Name, _, _, Percent), List),
    min_list(List, Min),
    findall(Name, ( client(Name, _, _, Percent), Percent =:= Min ), Res).

% ж. получить клиентов-задолжников
clients_with_negative_sum(List) :-
    findall( (Name, Val, Type), (client(Name, Val, Type, _), Val < 0), List ).
