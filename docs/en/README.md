# Project Launch Guide

## General
1. Rename `.env.example` to `.env`.
2. In the `# Run` section, set the value to "1" for the services you want to start:
   ```env
   # Run  
   RUN_GATEWAY=0  
   RUN_INFRA=0  
   RUN_MEDIA=1  
   RUN_LOGS_CLIENT=0  
   RUN_LOGS_SERVER=0  
   ```  
3. Adjust other `.env` variables as needed.
4. Start the services with the following command:
   ```shell
   make up
   ```

## Media Configuration

### Prowlarr Setup
1. Set up a login and password.
2. Add the FlareSolverr Indexer in the **Settings -> Indexers** section (`/settings/indexers`):
  - **Name:** FlareSolverr
  - **Tags:** flaresolverr
  - **Host:** `http://flaresolverr:8191/`
3. Add a new indexer in the **Indexer** section.
4. In **Settings -> Apps** (`/settings/indexers`), add applications. Retrieve the API Key from the corresponding application.

### Radarr Setup
1. Go to **Settings -> Media Manager** and configure the following:
  - Enable **Rename Movies**
  - Add **Root Folder:** `/data/media/movies`
2. Go to **Settings -> Quality** and configure preferences accordingly.
3. Go to **Settings -> Profiles** and adjust the profile (remove unnecessary ones).
4. Go to **Settings -> Download Client** and configure it.

## Logs-Server Configuration

### Prometheus Setup
If you have `node-exporter` and `cadvisor` running, create the following files (based on the examples in the same directory):
- `volumes/logs-server/prometheus/cadvisor.yml`
- `volumes/logs-server/prometheus/node-exporter.yml`  
