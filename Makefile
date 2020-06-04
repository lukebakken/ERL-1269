run: test_port.beam
	erl -eval 'test_port:run(), init:stop().'

test_port.beam: test_port.erl
	erlc test_port.erl
