opt_type(a, add, boolean).
opt_type(m, message, string).

opt_help(add, 'Add all files').
opt_help(message, 'Message to add to the summary').

main :-
    current_prolog_flag(argv, Argv),
    main(Argv).

main(Argv) :-
  argv_options(Argv, _Positional, Options),
  process_all(Options),
  ( memberchk(message(_), Options) -> true ; read_summary(Summary), writeln(Summary) ).

process_all(Options) :-
  forall(member(Option, Options), process(Option)).

process(add(true)) :-
  writeln("git add all").

process(message(Summary)) :-
  atom_concat("git commit -m ", Summary, Cmd),
  writeln(Cmd).

read_summary(Summary) :-
  write("Summary > "),
  read_line_to_string(user_input, Summary).