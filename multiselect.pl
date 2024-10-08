:- use_module(library(apply)).

clear_screen :- write('\e[H\e[2J').
is_true_tuple((_, true)).

multiselect(Pos, List, Result) :-
  clear_screen,
  display(Pos, List),
  read_key(Key),
  ( Key = quit -> include(is_true_tuple, List, Result)
  ; parse(Key, Pos, List, Result)
  ).

read_key(Key) :-
  get_single_char(Code),
  ( Code = 32 -> Key = select % Spacebar
  ; Code = 106 -> Key = down  % 'j' key
  ; Code = 107 -> Key = up    % 'k' key
  ; Code = 113 -> Key = quit  % 'q' key
  ).

parse(up, Pos, List, Result) :-
  NewPos is max(Pos - 1, 0),
  multiselect(NewPos, List, Result).

parse(down, Pos, List, Result) :-
  length(List, Length),
  NewPos is min(Pos + 1, Length - 1),
  multiselect(NewPos, List, Result).

parse(select, Pos, List, Result) :-
  neg_nth_item(Pos, List, NewList),
  multiselect(Pos, NewList, Result).

neg_nth_item(Pos, List, Result) :- 
  nth0(Pos, List, (V, B), Rest),
  nth0(Pos, Result, (V, \+ B), Rest).

display(_, []).
display(Pos, [ (X, S) | Xs ]) :-
  ( Pos == 0 -> write('↦ '); write('  ') ),
  ( S -> write('⦿ ') ; write('○ ') ),
  writeln(X),
  PosNew is Pos - 1,
  display(PosNew, Xs).
