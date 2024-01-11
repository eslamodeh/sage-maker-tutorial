.DEFAULT_GOAL := error

clean:
	docker rmi -f sagemaker-tf-phishing-serving;

build:
	echo "Building image:"
	docker build -t sagemaker-tf-phishing-serving . --no-cache;

run_bash:
	echo "Running bash:"
	docker run -it sagemaker-tf-phishing-serving /bin/bash

error:
	@echo "Please choose one of the following target: build"
	@exit 2
