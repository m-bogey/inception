NAME=inception

all: up

up:
	mkdir -p /home/mbogey/data /home/mbogey/data/mariadb /home/mbogey/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down -v

clean: down
	docker system prune -af --volumes
	rm -rf /home/mbogey/data

re: clean up

