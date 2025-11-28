# nginx: 
# 	@docker build -t "nginx42" requirments/srcs/nginx

# rm-nginx:
# 	@docker rmi nginx42

# maria:
# 	@docker build -t "mariadb42" requirments/srcs/mariadb

# rm-maria:
# 	@docker rmi mariadb42

# word:
# 	@docker build -t "wordpress42" requirments/srcs/wordpress

# rm-word:
# 	@docker rmi wordpress42

# COLOR_RESET=\033[0m
# COLOR_GREEN=\033[0;32m
# COLOR_YELLOW=\033[1;33m
# COLOR_CYAN=\033[0;36m
# COLOR_RED=\033[0;31m
# COLOR_MAGENTA=\033[0;35m
# COLOR_WHITE=\033[0;37m

# help:
# 	@echo "$(COLOR_GREEN)You can use the following commands:$(COLOR_RESET)"
# 	@echo "[$(COLOR_YELLOW)make nginx$(COLOR_RESET)] -> $(COLOR_CYAN)to create nginx image$(COLOR_RESET)"
# 	@echo "[$(COLOR_YELLOW)make maria$(COLOR_RESET)] -> $(COLOR_CYAN)to create mariadb image$(COLOR_RESET)"
# 	@echo "[$(COLOR_YELLOW)make word$(COLOR_RESET)] -> $(COLOR_CYAN)to create wordpress image$(COLOR_RESET)"
# 	@echo "$(COLOR_WHITE)for removing an image add the '$(COLOR_RED)rm-$(COLOR_WHITE)' prefix followed by the make name of the command, e.g. $(COLOR_YELLOW)make rm-$(COLOR_YELLOW)maria$(COLOR_RESET)"
# .silent:
all : up

up : 
	@docker compose -f srcs/docker-compose.yml up --build -d

up-build :
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

build:
# 	mkdir -p /home/ciusca/data/mysql
# 	mkdir -p /home/ciusca/data/wordpress
	@docker-compose  -f ./srcs/docker-compose.yml up --build -d

down : 
	@docker-compose -f ./srcs/docker-compose.yml down

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop

start : 
	@docker-compose -f ./srcs/docker-compose.yml start

rm:
	@docker rmi wordpress-image
	@docker rmi mariadb-image
	@docker rmi nginx-image

logs:
	@docker compose -f srcs/docker-compose.yml logs

re: down build up

status : 
	@docker ps