tests: test_credentials test_testmake_directory

.PHONY: tests test_credentials test_testmake_directory

test_credentials:
	cat /.vault/.secrets | grep BITBUCKET_USERNAME

test_testmake_directory:
	[ -d /home/ciencia_datos/.testmake ]
