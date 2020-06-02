This is the command that works and is what I am trying to run via `spawn_executable`:

```
C:\Users\lbakken\issues\erlang\ERL-1269>cmd.exe /Q /C "echo off && call ".\dir with space\test.bat""
HELLO WORLD
```

This is the output of the `test_port` module:

```
C:\Users\lbakken\issues\erlang\ERL-1269>.\run.bat

C:\Users\lbakken\issues\erlang\ERL-1269>erlc test_port.erl   && erl -eval "test_port:run(), init:stop()."
Arg: echo off && call ".\dir with space\test.bat"
Eshell V10.7  (abort with ^G)
1> output: '\".\dir with space\test.bat\"' is not recognized as an internal or external command,
operable program or batch file.
1> exit status: 11>
```
