-module(test_port).

-export([run/0]).

run() ->
    Args = ["/Q", "/C", ".\\dir with space\\test.bat", "&&", "set"],
    io:format("Args: ~p~n", [Args]),
    Opts = [{args, Args}, hide, binary, stderr_to_stdout, exit_status],
    run_with_executable("echoargs.exe", Opts),
    run_with_executable("cmd.exe", Opts).

run_with_executable(Exe0, Opts) ->
    case os:find_executable(Exe0) of
        false ->
            error;
        Exe1 ->
            io:format("~n~nExe1: ~p~n", [Exe1]),
            Port = erlang:open_port({spawn_executable, Exe1}, Opts),
            receive_data(Port)
    end.

receive_data(Port) ->
    receive
        {Port, {exit_status, ExitStatus}} ->
            io:format("exit status: ~b", [ExitStatus]);
        {Port, {data, Chunk}} ->
            io:format("output: ~ts", [Chunk]),
            receive_data(Port)
    end.
