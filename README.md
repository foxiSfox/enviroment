# Запуск проекта

## Общие
1. Переименовать .env.example в .env
2. В секции # Run установить значение "1" у сервисов, которые собираетесь запускать
   ```.env
   # Run
   RUN_GATEWAY=0
   RUN_MEDIA=1
   RUN_LOGS_CLIENT=0
   RUN_LOGS_SERVER=0 
   ```
3. Скорректировать другие переменные .env по своему усмотрению
4. Запустить сервисы командой:
   ```shell
   make up
   ```

## Настройка Media

### Настройка Prowlarr
1. Установить Логин/Пароль
2. Добавить Indexer FlareSolverr в разделе Settings->Indexers (/settings/indexers)
   - Name: FlareSolverr
   - Tags: flaresolverr
   - Host: http://flaresolverr:8191/
3. В разделе Indexer добавить новый.
4. Добавить Apps в разделе Settings-Apps (/settings/indexers). Api Key взять из соответствующего приложения.

### Настройка Radarr
1. Перейти в Settings->Media Manager и сделать следующие настройки:
   - включить "Rename Movies"
   - добавить Root Folder: /data/media/movies
2. Перейти в Setting->Quality и настроить по своим предпочтениям.
3. Перейти в Settings->Profiles, и настроить профиль (все ненужно можно удалить)
4. Перейти в Settings->Download Client и настроить его.
