%Question 1
%Increment - incr(P1,P2)
incr(null, f1(null)).   %X = f1(null)
incr(f0(X), f1(X)).
incr(f1(X), f0(Y)) :- incr(X, Y).

%Question 2
%legal - legal(P)
legal(f0(null)).
legal(X) :- legal(Y), incr(Y, X).

%incR function
incrR(X, Y) :- legal(X), incr(X, Y).

%Question 3
%add - add(P1,P2,P3)
add(f0(null), X, X).
add(X, Y, Z) :- incr(A, X), add(A, Y, B), incr(B, Z).

%Question 4
%multiply - mult(P1,P2,P3)
mult(f1(null), X, X).
mult(X, Y, Z) :- incr(A, X), mult(A, Y, B), add(Y, B, Z).

%Question 5
%reverse - reverse(P,revP)
reverse(X, Y):- reverse(X, null, Y).

reverse(null, X, X).
reverse(f0(X), A, Y) :- reverse(X, f0(A), Y).
reverse(f1(X), A, Y) :- reverse(X, f1(A), Y).

%Question6
%normalize - normalize(P,Pn)
normalize(null, f0(null)).
normalize(f0(null), f0(null)).
normalize(X, Y) :- revers(X, A), remove(A, B), revers(B, Y).

%enc(null) := 0
%enc(f0(X)) := 2 × enc(X)
%enc(f1(X)) := 2 × enc(X) + 1.

remove(f1(X), f1(X)).
remove(f0(null),f0(null)).
remove(f0(X), C) :- remove(X, C).


%Test cases
% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
add(T1,T2,SumT), pterm2numb(SumT,Sum).
% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).
% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).
% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).
% make a pterm T from a number N numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).
% make a number N from a pterm T pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.
% reversible ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).






