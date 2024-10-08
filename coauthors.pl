
coauth_list(List) :-
    setup_call_cleanup(
          process_create(path(git), ['shortlog', '-sne', '--all'], [stdout(pipe(Out))]),
          read_string(Out, _, Str),
          close(Out)
          ),
    split_string(Str, "\n", "", Lines),
    coauth_list_parse(Lines, List0),
    coauth_self(Nm,Em),
    Self = ((Nm, Em), _),
    (member(Self, List0) -> select(Self, List0, List)
    ; List = List0).

coauth_list_parse([], []).
coauth_list_parse([""], []).
coauth_list_parse([Line|Lines], [H|List]) :-
    split_string(Line, "\t", "", [_Commits, NameEmail]),
    split_string(NameEmail, "<", " ", [Name, Email0]),
    split_string(Email0, ">", " ", [Email|_]),
    H = ((Name, Email), false),
    coauth_list_parse(Lines, List).
      


coauth_self(Name, Email) :-
    setup_call_cleanup(
        process_create(path(git), ['config', 'user.name'], [stdout(pipe(UserName))]),
        read_string(UserName, _, Name0),
        close(UserName)
        ),
    split_string(Name0, "\n", "", [Name|_]),
    setup_call_cleanup(
        process_create(path(git), ['config', 'user.email'], [stdout(pipe(UserEmail))]),
        read_string(UserEmail, _, Email0),
        close(UserEmail)
        ),
    split_string(Email0, "\n", "", [Email|_]).
  

