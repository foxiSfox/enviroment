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


## Time Machine Backup Service
The template `templates/services/backup/timemachine.yml` spins up a Samba-based server that advertises itself over Bonjour for macOS Time Machine clients.

### Networking
- Uses `network_mode: host` to broadcast mDNS/Bonjour without extra Avahi setup. Expose ports manually if you prefer stricter firewall rules.

### Environment Variables
- Defaults live in `services/backup/timemachine/.env.local`; duplicate it if you need service-specific overrides.
- Enable the stack by setting `RUN_BACKUP=1` in your project `.env` before invoking the Make targets.
- `AVAHI_NAME` controls the visible host name in Finder/Time Machine.
- `MODEL` should stay on a supported Apple identifier such as `TimeCapsule` so the service is recognised correctly.
- `ACCOUNT_backup`, `UID_backup`, and `GID_backup` define the login credentials and numeric IDs for the backup user; adjust them to match your host.
- `SAMBA_CONF_LOG_LEVEL` keeps Samba logs at level 1 for easier debugging without noise.

### Time Machine Share Configuration
- `SAMBA_VOLUME_CONFIG_timemachine` declares the Time Machine share. It mounts user-specific folders under `/shares/timemachine/%U` and enables the required `fruit:time machine = yes` flag.
- Set `fruit:time machine max size` to the quota you want (e.g. `500G`, `1T`).
- Keep the recommended macOS compatibility directives (`fruit:aapl`, `fruit:metadata`, `ea support`) to preserve extended attributes.

### Volumes
- Map a host path (for example `/Users/<user>/backups:/shares/timemachine`) to persist backups.
- Optionally mount an Avahi services directory to publish additional Bonjour records.
