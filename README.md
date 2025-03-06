# Запуск проетк

1. Переименовать .env.example в .env
2. С помощью команд make запускать проекты

P.S:
1. make help даст подсказку по командам

## Запуск файла

```sh
docker compose --project-directory=. -f composes/gateway/compose.yml up
```
