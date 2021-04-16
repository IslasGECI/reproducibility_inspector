tests: \
		test_credentials \
		test_testmake_directory

.PHONY: \
		test_credentials \
		test_testmake_directory \
		tests

test_credentials:
	cat /.vault/.secrets | grep BITBUCKET_USERNAME

test_testmake_directory:
	[ -d /home/ciencia_datos/.testmake ]
