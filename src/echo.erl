-module(echo).

-export([
         start/0,
         print/1,
         stop/0
]).

-export([
         loop/1
]).

start() ->
    Pid = spawn(echo, loop, [0]),
    register(echo, Pid),
    Pid.

print(Term) ->
    echo!{print, self(), Term},
    receive
        {reply, Reply} -> Reply
    end.

stop() ->
    echo!{stop, self()},
    receive
        {reply, Reply} -> Reply
    end.


loop(Counter) ->
    io:format("printed messages ~w~n", [Counter]),
    receive
        {print, Pid, Message} ->
            io:format("~w~n", [Message]),
            Pid!{reply, print},
            NewCounter = Counter + 1,
            loop(NewCounter);
        {stop, Pid} ->
            Pid!{reply, stop}
    end.
