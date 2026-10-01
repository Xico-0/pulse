# pulse

Monitoring of the availability of your web services: checks, history, alerts,
and a public status page. Built to learn real DevOps muscle memory — from
`docker compose` to CI/CD.

> This is the start of a learning project (Phase 1: git + repo). More coming.

## Structure

```
app/        FastAPI backend (auth, checks, history, metrics)
worker/     background prober reading a Redis queue
web/        public status page
nginx/      reverse proxy
prometheus/ grafana/   observability
deploy/     systemd units, ansible playbook, deploy script
.github/workflows/     CI (lint, test, build) and CD
```

## Plan

1. git + GitHub
2. Docker
3. Docker Compose
4. FastAPI backend
5. worker + Redis queue
6. status page + Telegram alerts + uptime stats
7. Prometheus / Grafana
8. GitHub Actions CI
9. CD to a VPS + Ansible (IaC)
10. README + screenshots + badges