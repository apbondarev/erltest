-module(echo).

-export([
         start/0,
         loop/1
]).

start() ->
    Pid = spawn(echo, loop, []),
    register(echo, Pid),
    ok.

loop(Args) ->
    receive
        {print, Message} -> io:format("~w~n", [Message])
    end,
    loop(Args),
    ok.
