NAME=inception

all: up

up:
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down -v

clean: down
	docker system prune -af --volumes

re: down up

