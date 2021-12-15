-module(main).
-export([main/0, run/0]).
-include("part1.erl").
-include("part2.erl").

% Trim a string
trim_string(S) -> re:replace(S, "\\s+", "", [global, {return, list}]).

% convert a string to an array of int
string_to_ints(S) ->
    case S of
        [] -> [];
        [C | CS] -> [C - 48] ++ string_to_ints(CS)
    end.

% Get all lines from a file
get_all_lines(Device) ->
    case io:get_line(Device, "") of
        eof  -> [];
        Line -> [string_to_ints(trim_string(Line))] ++ get_all_lines(Device)
    end.

% Read the lines of the file
readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    try get_all_lines(Device)
        after file:close(Device)
    end.

% Remove the entry point
convertData([[_ | CS] | RS]) -> [[0 | CS] | RS].

% Drop the first column of all the lines
dropCol(RS) -> [T || [_ | T] <- RS].

% Main
main() ->
    Data = convertData(readlines("input3")),
    io:format("Part 1: ~n"),
    io:format("~p~n", [part1(Data)]),
    io:format("Part 2: ~n"),
    io:format("~p~n", [part2(Data)]),
    io:format("OK~n").

run() -> main().
