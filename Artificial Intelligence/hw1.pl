add2frontier([], Rest, Rest).
add2frontier([H|T], Rest,[H|TRest]) :- add2frontier(T, Rest, TRest).

arc([H|T],Node,Cost,KB) :- member([H|B],KB), append(B,T,Node),
                           length(B,L), Cost is 1+L/(L+1).

heuristic(Node,H) :- length(Node,H).
goal([]).
reverse([],Z,Z).
reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

less_than([[Node1|_],Cost1],[[Node2|_],Cost2]) :-
heuristic(Node1,Hvalue1), heuristic(Node2,Hvalue2),
F1 is Cost1+Hvalue1, F2 is Cost2+Hvalue2,
F1 =< F2.

%astar/4
astar(Node, Path, Cost, KB) :- astar([Node, [Node], 0], Path, Cost, KB, []).

% astar/5 
astar_5([CurrentNode, NodePath, NodeCost], X, NodeCost, _, _) :- goal(CurrentNode), reverse(NodePath,X,[]).
astar_5([CurrentNode, NodePath, NodeCost], GoalPath, GoalCost, KB, Frontier) :-
    find_all(% find all frontier nodes and store in Children
        [ChildNode, [ChildNode|NodePath], ChildNodeCost], 
        (arc(CurrentNode, ChildNode, NewCost, KB), ChildNodeCost is NewCost + NodeCost), 
        Children
    ),
    add2frontier(Frontier, Children, SortedFrontier), 
    SortedFrontier = [NewNode | NewFrontier], % Separating new current node and new frontier list from SortedFrontier.
    astar_5(NewNode, GoalPath, GoalCost, KB, NewFrontier).
