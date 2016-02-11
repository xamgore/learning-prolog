% Задание 3.

рождение(иванова, лена, 22, июнь, 1971).
рождение(петров, сергей, 25, октябрь, 1973).
рождение(сидорова, оля, 1, декабрь, 1974).

любит(иванова, лена, книги).
любит(иванова, лена, танцы).
любит(петров, сергей, видео).
любит(сидорова, оля, кино).

% 1. Кто родился в 1971 году?
%  > иванова лена
рождение(Ф, И, _, _, 1971), format('~q ~q\n', [Ф, И]), fail.

% 2. Кто родился в октябре?
%  > петров сергей
рождение(Ф, И, _, октябрь, _), format('~q ~q\n', [Ф, И]), fail.

% 3. Кто любит книги?
%  > иванова лена
любит(Ф, И, книги), format('~q ~q\n', [Ф, И]), fail.

% 4. Кто любит и книги и танцы?
%  > иванова лена
любит(Ф, И, книги), любит(Ф, И, танцы), format('~q ~q\n', [Ф, И]), fail.