# Repository Guidelines

## Project Structure & Module Organization
Infrastructure code lives under `composes/` as Docker Compose bundles for gateway, media, infra, logs-client, and logs-server stacks. Service-specific configuration (dashboards, Dockerfiles, manifests) resides in `services/<domain>/`. Shared templates sit in `templates/`, while `volumes/` holds persisted Prometheus, Grafana, and media seed data. Operational docs are in `docs/` (localized `en` and `ru`), and automation helpers live in `scripts/` and `Makefile`. Use `test/` for backup fixtures and manual validation assets.

## Build, Test, and Development Commands
- `make up`: Build and start every stack that is toggled on in `.env` (`RUN_*` flags).
- `make down`: Stop all running stacks cleanly.
- `make reset`: Full rebuild cycle; handy after compose edits.
- `make up-<service>` / `make down-<service>`: Target a single compose file, e.g. `make up-media`.
- `make run-script script=cloudflare`: Execute helper scripts from `scripts/`.
- `docker compose --project-directory=. -f composes/media/compose.yml config`: Dry-run validation before shipping compose changes.

## Coding Style & Naming Conventions
Write YAML with two-space indentation and lowercase hyphenated keys to match existing compose files. Keep environment variables uppercase snake case (`RUN_LOGS_SERVER`). Mount paths should be absolute and stay consistent with `volumes/`. Shell scripts follow `set -euo pipefail` patterns; prefer POSIX sh-compatible syntax.

## Testing & Validation Guidelines
There is no automated CI; contributors must validate locally. Run the relevant `docker compose ... config` command per service and bring the stack up with the matching `make up-<service>` to confirm container health. Capture manual checks (`make ps-short`, Grafana dashboards, Prowlarr connectivity) in the PR description. Avoid committing generated data inside `volumes/`.

## Commit & Pull Request Guidelines
Follow Conventional Commit prefixes already in Git history (`feat:`, `chore:`, `docs:`). Summaries should stay under 72 characters, e.g. `feat: add sonarr volume examples`. PRs need a concise summary, linked issue (if any), screenshot or log excerpt for UI/observability tweaks, and a checklist of the stacks you exercised.

## Security & Configuration Tips
Copy `.env.example` to `.env` and only enable the stacks you truly need. Keep secrets out of Git—use local `.env` overrides and private volume mounts. Review `templates/networks.yml` when introducing new subnets, and ensure Cloudflare API tokens used by `scripts/cloudflare.sh` have least privilege.
