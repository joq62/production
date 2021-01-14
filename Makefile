all:
	erlc -o test_ebin test_src/*.erl;
	erlc -o ebin src/*.erl;
	rm -rf test_ebin/* test_src/*.beam src/*.beam *.beam;
	rm -rf terminal/ebin/* log* dbase* control*;
	rm -rf  *~ */*~ */*/*~ erl_cra*;
	rm -rf *_specs *_config *.log
doc_gen:
	echo glurk not implemented
log_terminal:
	rm -rf terminal/ebin/*;
	rm -rf  *~ */*~  erl_cra*;
#	common
	erlc -o terminal/ebin ../services/common_src/src/*.erl;
#	application terminal
	erlc -o terminal/ebin ../services/terminal_src/src/*.erl;
	erl -pa terminal/ebin -s terminal start -sname log_terminal -setcookie abc
alert_ticket_terminal:
	erl -pa terminal/ebin -s terminal start -sname alert_ticket_terminal -setcookie abc
test:
	rm -rf test_ebin/* test_src/*.beam src/*.beam *.beam;
	rm -rf terminal/ebin/* log* dbase* control*;
	rm -rf  *~ */*~  erl_cra*;
	rm -rf *_specs *_config *.log;
#	Common service
	erlc -o test_ebin ../services/common_src/src/*.erl;
	cp test_src/*.app test_ebin;	
	erlc -o test_ebin test_src/*.erl;
	erlc -o test_ebin src/*.erl;
	erl -pa test_ebin\
	    -setcookie abc\
	    -sname production_test\
	    -run production_test start
