.DEFAULT_GOAL := error

clean:
	docker rmi -f sagemaker-tf-phishing-serving;

build:
	echo "Building image:"
	docker build -t sagemaker-tf-phishing-serving . --no-cache;

build_m1:
	echo "Building image for m1:"
	docker build -t sagemaker-tf-phishing-serving . -f DockerfileM1 --no-cache;

run_bash:
	echo "Running bash:"
	docker run --rm -d -p 8080:8080 sagemaker-tf-phishing-serving

error:
	@echo "Please choose one of the following target: build"
	@exit 2
