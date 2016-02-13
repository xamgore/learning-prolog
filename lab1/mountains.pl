% Задание 12.

гора(европа, кавказ,  эльбрус, 5642).
гора(европа, кавказ,  казбек,  5033).
гора(европа, кавказ,  аишхо,   2391).
гора(европа, альпы,   монблан, 4810).
гора(азия,   гималаи, эверест, 8848).


% 1. Какие горы есть в Европе?
гора(европа, _, Гора, _).

% 2. Какие горы имеют высоту, больше 7000 км?
гора(_, _, Гора, Высота), Высота >= 7000.

% 3. Какие горы есть на Кавказе? А в Альпах?
гора(_, кавказ, Название, _); гора(_, альпы, Название, _).

% 4. Ещё три вопроса.
% ... скукота
