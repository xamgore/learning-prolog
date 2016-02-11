%parent(родитель,ребенок,дата_рождения).
parent(tom,rid,1950).
parent(tom,ron,1952).
parent(tom,ann,1955).
parent(rid,jhon,1971).
parent(rid,lew,1977).
parent(ron,mary,1980).
parent(ron,liz,1982).
parent(ron,serg,1985).
parent(ann,pola,1975).
parent(jhon,ivan,1993).
parent(lew,kate,1999).
parent(lew,kiki,2002).
parent(mary,petr,2003).
parent(liz,alex,2005).
parent(liz,katerina,2009).
parent(serg,eva,2010).
parent(pola,luka,1993).
parent(luka,sam,2011).

%gender(пол,имя_человека).
gender(male,tom).
gender(male,rid).
gender(male,ron).
gender(male,jhon).
gender(male,lew).
gender(male,serg).
gender(male,sam).
gender(male,luka).
gender(male,alex).
gender(male,petr).
gender(male,ivan).
gender(female,ann).
gender(female,liz).
gender(female,kate).
gender(female,kiki).
gender(female,mary).
gender(female,katerina).
gender(female,eva).

%isSyster(сестра,для_кого).  isSyster(A,B), т.е. А - сестра для В
isSyster(A,B) :- gender(female,A), parent(X,A,_), parent(X,B,_), A\=B.

%grossFather(дед,внук_внучка).
grossFather(A,B) :- parent(A,X,_), parent(X,B,_), gender(_,A).

%predok(A,B). А - предок для В
predok(A,B) :- parent(A,B,_).
predok(A,B) :- parent(A,C,_), predok(C,B).

%hasGrandDaughter(Grandpa, Girl).
hasGrandDaughter(Grandpa, Girl) :-
    grossFather(Grandpa, Girl),
    gender(female, Girl).


% 7. Кто из мальчиков родились в семье?
gender(male, Name).

% 8. Есть ли внучка у Рона? Как ее зовут?
hasGrandDaughter(ron, G).
% G = katerina ;
% G = eva.

% 9. Кто является предком для Петра?
predok(P, petr).
% P = mary ;
% P = tom ;
% P = ron.

% 10) Кто чей родитель?
parent(P, C, _).
