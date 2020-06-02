-module(test_port).

-export([run/0]).

run() ->
    Batch = ".\\dir with space\\test.bat",
    Arg = io_lib:format("echo off && call \"~ts\"", [Batch]),
    io:format("Arg: ~s~n", [Arg]),
    Args = ["/Q", "/C", Arg],
    Opts = [{args, Args}, hide, binary, stderr_to_stdout, exit_status],
    case os:find_executable("cmd.exe") of
        false ->
            error;
        Exe ->
            Port = erlang:open_port({spawn_executable, Exe}, Opts),
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
