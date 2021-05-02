tests: \
		test_credentials \
		test_testmake_directory

.PHONY: \
		test_credentials \
		test_testmake_directory \
		tests

HOME = /home/ciencia_datos

test_credentials:
	ssh -T git@bitbucket.org

test_testmake_directory:
	[ -d "${HOME}/.testmake" ]
