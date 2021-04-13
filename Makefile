tests:  \ 
		test_credentials \
		test_testmake_directory

.PHONY: \
		ping \
		playbook \
		test_credentials \
		test_testmake_directory \
		tests

ping:
	ansible reproducibility_inspector --module-name ping --become
	
playbook:
	ansible-playbook ansible-playbook.yml

test_credentials:
	cat /.vault/.secrets | grep BITBUCKET_USERNAME

test_testmake_directory:
	[ -d /home/ciencia_datos/.testmake ]
