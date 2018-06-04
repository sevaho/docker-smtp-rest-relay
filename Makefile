ROOT_DIR := docker-smtp-relay
IP 		:= 1.1.1.1

help: ## Show this help message (default)]
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m \033[35m%s\033[0m\n", $$1, $$2}' $(MAKEFILE_LIST)

run: ## DEV : run locally
	echo "run locally, uncomment what you need in the Makefile"
	#npm install --prefix app # nodejs
	#npm start --prefix app # nodejs
	pip install --user -r app/requirements.txt
	# python app/app.py # python
	gunicorn --workers=2 --bind=0.0.0.0:8000 --chdir app app:app # python-flask

cleanup: ## DEV : cleanup
	echo "install locally"
	#rm -rf app/node_modules # nodejs
	#rm -rf app/etc # nodejs

install: ## DEV: install locally
	echo "install locally"
	echo "TO IMPLEMENT"

docker: ## DEV DOCKER: running docker
	echo "running docker locally, change docker run to docker run -p ***:*** if you need network capabilities"
	docker build -t "$(ROOT_DIR)" .
	docker run -p 8000:8000 "$(ROOT_DIR)"

docker-daemon: ## DEV DOCKER: daemonize your docker container to the local system
	echo "running docker locally, change docker run to docker run -p ***:*** if you need network capabilities"
	docker build -t "$(ROOT_DIR)" .
	docker run -d --restart=always -p 8000:8000 --name="$(ROOT_DIR)" "$(ROOT_DIR)"

docker-cleanup: ## DEV DOCKER : docker cleanup
	echo "stop docker container and remove the image so the app name can be used again"
	docker stop "$(ROOT_DIR)"
	docker rm "$(ROOT_DIR)"

prod-build: ## make local docker
	rm -rf app/node_modules
	docker build -t docker.sevaho.io/"$(ROOT_DIR)" .
	docker push docker.sevaho.io/"$(ROOT_DIR)"

prod-deploy: ## make local docker
	ssh -fL 2201:192.168.0.4:22 sevahoSSHServer sleep 5
	ssh sevaho@localhost -p 2201 "docker pull docker.sevaho.io/\"$(ROOT_DIR)\""
	ssh sevaho@localhost -p 2201 "docker run -d --net production --ip \"$(IP)\" --restart=always --name  \"$(ROOT_DIR)\" --dns 172.32.0.2 docker.sevaho.io/\"$(ROOT_DIR)\""

prod-cleanup: ## clean up docker
	ssh -fL 2201:192.168.0.4:22 sevahoSSHServer sleep 5
	ssh sevaho@localhost -p 2201 "docker ps | grep \"$(ROOT_DIR)\" && docker stop \"$(ROOT_DIR)\" || echo \"no live container $(ROOT_DIR)\""
	ssh sevaho@localhost -p 2201 "docker ps -a | grep \"$(ROOT_DIR)\" && docker rm \"$(ROOT_DIR)\" || echo \"no live container $(ROOT_DIR)\""
