% Задание 10.

играет(на(скрипке),    мартышка).
играет(на(альте),      осёл).
играет(на(виолончели), козёл).
играет(на(контрабасе), мишка).

скрипач(С)      :- играет(на(скрипке),    С).
альтист(А)      :- играет(на(альте),      А).
виолончелист(В) :- играет(на(виолончели), В).
контрабасист(К) :- играет(на(контрабасе), К).

квартет(С, А, В, К) :-
    скрипач(С), альтист(А), виолончелист(В), контрабасист(К).

ребята_могут_в_квартет(С, А, В, К) :-
    permutation([С, А, В, К], [Сс, Аа, Вв, Кк]),
    квартет(Сс, Аа, Вв, Кк).

% 1. Кто играет на альте?
forall( играет(на(альте), Кто), format('~q ', [Кто]) ).

% 2. На чем играет мартышка?
forall( играет(На_чём, мартышка), writeln(На_чём) ).

% 3. Образуют ли квартет Мартышка, Осел, Козел и Мишка?
ребята_могут_в_квартет(мартышка, осёл, козёл, мишка).