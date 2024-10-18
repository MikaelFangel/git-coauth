:- ensure_loaded('coauthors.pl').
:- ensure_loaded('multiselect.pl').
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
  ( memberchk(message(Summary), Options) -> true ; read_summary(Summary) ),
  coauth_list(Authors),
  multiselect(0, Authors, Selected),
  ( var(Selected) -> Selected = [] ; true ),
  format_summary(Summary, Selected, FinalSummary),
  shell(FinalSummary).

process_all(Options) :-
  forall(member(Option, Options), process(Option)).

process(add(true)) :-
  shell("git add --all").

process(message(_Summary)).

read_summary(Summary) :-
  writeln("\033[37mTerminate with CTRL+D\033[0m"),
  write("Summary > "),
  read_string(user_input, _, Summary).

format_summary(Summary, Authors, FinalSummary) :-
  atomic_list_concat(["git commit -m \"", Summary, "\n"], Description),
  maplist(format_author, Authors, AuthorLines),
  atomic_list_concat([Description | AuthorLines], '\n', NewDescription),
  atom_concat(NewDescription, "\"", FinalSummary).

format_author((NameEmail, _), Line) :-
  format(atom(Line), 'Co-Authored-By: ~w', [NameEmail]).
