all: echo.beam sort.beam

echo.beam:
	erlc +debug_info echo.erl

sort.beam:
	erlc +debug_info sort.erl

clean:
	rm *~ *.beam
