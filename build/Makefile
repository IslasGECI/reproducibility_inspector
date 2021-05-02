tests: \
		test_credentials \
		test_testmake_directory

.PHONY: \
		container \
		image \
		test_credentials \
		test_testmake_directory \
		tests

CONTAINER_HOME = /home/ciencia_datos
HOST_HOME = $${HOME}

container:
	docker run \
		--detach \
		--name reproducibility_inspector \
		--restart always \
		--volume ${HOST_HOME}/.ssh:${CONTAINER_HOME}/.ssh:ro \
		--volume ${HOST_HOME}/.testmake:${CONTAINER_HOME}/.testmake \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		islasgeci/reproducibility_inspector:latest

image:
	docker build --tag islasgeci/reproducibility_inspector:latest .

test_credentials:
	[ -d "${HOST_HOME}/.ssh" ]

test_testmake_directory:
	[ -d "${HOST_HOME}/.testmake" ]
