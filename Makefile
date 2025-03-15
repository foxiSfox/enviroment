include .env

PROJECT_DIR=.

COMPOSE_GATEWAY=composes/gateway/compose.yml
COMPOSE_MEDIA=composes/media/compose.yml
COMPOSE_LOGS_CLIENT=composes/logs-client/compose.yml
COMPOSE_LOGS_SERVER=composes/logs-server/compose.yml

default: help

# Вывести список всех доступных команд
help:
	@echo "\nДоступные команды:\n"
	@echo "  make up                - 🚀 Запустить все сервисы"
	@echo "  make down              - 🛑 Остановить все сервисы"
	@echo "  make reset             - 🔄 Перезапустить все сервисы (down + up)"
	@echo "\nУправление отдельными сервисами:"
	@echo "  make up-gateway        - ▶️  Запустить gateway сервис"
	@echo "  make up-media          - ▶️  Запустить media сервис"
	@echo "  make up-logs-client    - ▶️  Запустить logs-client сервис"
	@echo "  make up-logs-server    - ▶️  Запустить logs-server сервис"
	@echo "  make down-gateway      - ⏹️  Остановить gateway сервис"
	@echo "  make down-media        - ⏹️  Остановить media сервис"
	@echo "  make down-logs-client  - ⏹️  Остановить logs-client сервис"
	@echo "  make down-logs-server  - ⏹️  Остановить logs-server сервис"
	@echo "  make reset-gateway     - 🔁 Перезапустить gateway сервис"
	@echo "  make reset-infra       - 🔁 Перезапустить infra сервис"
	@echo "  make reset-logs-client - 🔁 Перезапустить logs-client сервис"
	@echo "  make reset-logs-server - 🔁 Перезапустить logs-server сервис"
	@echo "\nПрочее:"
	@echo "  make run-script script=<script_name> - 📝 Запустить скрипт из директории scripts (cloudflare)"
	@echo "  make clean             - 🧹 Очистить неиспользуемые Docker-объекты"
	@echo "  make ps-short          - 📋 Показать запущенные контейнеры в кратком виде"

# Запустить скрипт
run-script:
	@chmod +x scripts/$(script).sh
	@bash scripts/$(script).sh

# Запустить все сервисы
up: up-gateway up-media up-logs-client up-logs-server

# Остановить все сервисы
down: down-gateway down-media down-logs-client down-logs-server

# Перезапустить все сервисы
reset: reset-gateway reset-infra reset-logs-client reset-logs-server

# Команды для запуска отдельных сервисов
up-gateway:
	@if [ "$$(echo $(RUN_GATEWAY))" -eq "1" ]; \
	then docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_GATEWAY} up -d --build; \
	fi

up-media:
	@if [ "$$(echo $(RUN_MEDIA))" -eq "1" ]; \
	then docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_MEDIA} up -d --build; \
	fi

up-logs-client:
	@if [ "$$(echo $(RUN_LOGS_CLIENT))" -eq "1" ]; \
	then docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_LOGS_CLIENT} up -d --build; \
	fi

up-logs-server:
	@if [ "$$(echo $(RUN_LOGS_SERVER))" -eq "1" ]; \
	then docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_LOGS_SERVER} up -d --build; \
	fi

# Команды для остановки отдельных сервисов
down-gateway:
	docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_GATEWAY} down

down-media:
	docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_MEDIA} down

down-logs-client:
	docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_LOGS_CLIENT} down

down-logs-server:
	docker compose --project-directory=$(PROJECT_DIR) -f ${COMPOSE_LOGS_SERVER} down

# Команды для перезапуска отдельных сервисов
reset-gateway: down-gateway up-gateway

reset-infra: down-media up-media

reset-logs-client: down-logs-client up-logs-client

reset-logs-server: down-logs-server up-logs-server

# Очистить неиспользуемые Docker-объекты
clean:
	docker system prune -f

# Показать запущенные контейнеры в кратком виде
ps-short:
	docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"
