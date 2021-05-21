tests: \
		test_credentials \
		test_testmake_directory

.PHONY: \
		container \
		image \
		test_credentials \
		test_testmake_directory \
		tests

HOME = /home/ciencia_datos

container:
	docker run \
		--detach \
		--name reproducibility_inspector \
		--restart always \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		--volume ${HOME}/.testmake:${HOME}/.testmake \
		--volume ${HOME}/.vault:${HOME}/.vault \
		islasgeci/reproducibility_inspector:latest

image:
	docker build --tag islasgeci/reproducibility_inspector:latest .

test_credentials:
	[ -f ${HOME}/.vault/.secrets ]

test_testmake_directory:
	[ -d ${HOME}/.testmake ]
