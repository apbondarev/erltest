-module(sort).
-author("user").

-export([
         merge_sort/1,
         qsort/1
]).

reverse(L) -> reverse(L, []).

reverse([], R) -> R;
reverse([H|Tail], R) -> reverse(Tail, [H|R]).


sublist_head(L, Length) ->
  R = sublist_head(L, [], Length),
  reverse(R).

sublist_head(_, Result, 0) -> Result;
sublist_head([H|Tail], Result, Length) -> sublist_head(Tail, [H|Result], Length - 1).


sublist_tail(L, Length) -> sublist_tail_helper(L, length(L) - Length).

sublist_tail_helper(L, 0) -> L;
sublist_tail_helper([_|Tail], Length) when Length > 0 -> sublist_tail_helper(Tail, Length - 1).


split(List) ->
  Len = length(List),
  L1 = Len div 2,
  L2 = Len - L1,
  A = sublist_head(List, L1),
  B = sublist_tail(List, L2),
  {A, B}.


merge_lists(L1, L2) -> merge_lists(L1, L2, []).

merge_lists([], [], R) -> reverse(R);
merge_lists([], [H|T], R) -> merge_lists([], T, [H|R]);
merge_lists([H|T], [], R) -> merge_lists(T, [], [H|R]);
merge_lists([H1|L1], [H2|L2], R) ->
  if
    H1 =< H2 -> merge_lists(L1, [H2|L2], [H1|R]);
    true -> merge_lists([H1|L1], L2, [H2|R]) 
  end.

merge_sort([]) -> [];
merge_sort([A]) -> [A];
merge_sort([A,B]) ->
  if
    A =< B -> [A,B];
    true -> [B,A]
  end;
merge_sort(List) ->
  {A1, A2} = split(List),
  S1 = merge_sort(A1),
  S2 = merge_sort(A2),
  merge_lists(S1, S2).

qsort([]) ->
    [];
qsort([A]) ->
    [A];
qsort([A,B]) ->
    if
        A=<B -> [A,B];
        true -> [B,A]
    end.
