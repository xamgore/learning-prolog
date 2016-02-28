% Определите рекурсивное отношение НОД (наибольший общий делитель).

gcd(X, X, X).

% X: 2+2, Y
gcd(X, Y, D) :- X > Y,
    Yn is X - Y,
    gcd(Y, Yn, D).

gcd(X, Y, D) :- X < Y,
    Yn is Y - X,
    gcd(X, Yn, D).
