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
		--volume $${HOME}/.ssh:/root/.ssh:ro \
		--volume ${HOME}/.testmake:${HOME}/.testmake \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		islasgeci/reproducibility_inspector:latest

image:
	docker build --tag islasgeci/reproducibility_inspector:latest .

test_credentials:
	ssh -T git@bitbucket.org

test_testmake_directory:
	[ -d "${HOME}/.testmake" ]
