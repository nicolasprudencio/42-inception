LOGIN = nprudenc

DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml

config:
	@sudo mkdir -p "/home/${LOGIN}/data/mariadb"
	@sudo mkdir -p "/home/${LOGIN}/data/wordpress"

	@if ! sudo grep -q "${LOGIN}.42.fr" /etc/hosts; then \
		echo "127.0.0.1	${LOGIN}.42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi

all: config up

down:
	${DOCKER_COMPOSE} down

ps:
	${DOCKER_COMPOSE} ps

up: build
	${DOCKER_COMPOSE} up -d

build:
	${DOCKER_COMPOSE} build

volumes:
	docker volume ls

clean:
	${DOCKER_COMPOSE} down --rmi all --volumes

fclean: clean
	sudo sed -i "/nprudenc/d" /etc/hosts
	sudo rm -rf "/home/${LOGIN}"
	rm srcs/.env
	sudo docker system prune --force --all --volumes

re: fclean all

.PHONY: config all down ps up build volumes clean fclean re

.DEFAULT_GOAL = all
