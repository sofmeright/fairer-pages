# Docker Deployment

## Quick Start

```bash
docker run -d --name fairer-pages --restart always -p 8023:8080 prplanit/fairer-pages:latest
```

Container listens on port **8080**, runs as non-root (UID 10000), and supports `--read-only` with `--tmpfs /tmp`.

## Docker Compose

Copy or reference the [docker-compose.yaml](docker-compose.yaml) in this directory and optionally create a `.env` file from [.env.example](.env.example):

```bash
docker compose up -d
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `LISTEN_PORT` | `8080` | Port nginx listens on inside the container |
| `LOG_LEVEL` | `warn` | Nginx log level (`debug`, `info`, `notice`, `warn`, `error`, `crit`) |
| `WORKER_PROCESSES` | `auto` | Nginx worker processes |
| `FAIRER_PLAYLIST_CSV` | _(unset)_ | Comma-separated theme list for the default playlist |
| `FAIRER_PLAYLIST_FILE` | _(unset)_ | Path to a YAML playlist config file (takes priority over CSV) |

## Custom Playlists

### CSV Mode (Simple)

Restrict the random theme pool to specific themes:

```bash
docker run -e FAIRER_PLAYLIST_CSV="trollface,blank-state,dogatemypage" prplanit/fairer-pages
```

### YAML Mode (Advanced)

Mount a custom playlist file for named playlists, per-error-code overrides, and YAML anchors:

```bash
docker run \
  -v /path/to/playlists.yml:/etc/fairer-pages/playlists.yml:ro \
  -e FAIRER_PLAYLIST_FILE=/etc/fairer-pages/playlists.yml \
  prplanit/fairer-pages
```

See [default-playlists.yml](../../default-playlists.yml) for the full default configuration and syntax reference.

## Building from Source

```bash
git clone https://github.com/sofmeright/fairer-pages && cd fairer-pages
docker build -t fairer-pages .
docker run -d -p 8023:8080 fairer-pages
curl http://localhost:8023/fairer-pages/back2thefuture/404.html
```

## Security

The container is hardened out of the box:

- Runs as non-root user (UID/GID 10000)
- Supports read-only root filesystem (`--read-only`)
- Only needs a tmpfs at `/tmp` for runtime nginx config
- All capabilities dropped (`--cap-drop ALL`)
- No new privileges (`--security-opt no-new-privileges:true`)

```bash
docker run -d \
  --read-only \
  --tmpfs /tmp \
  --cap-drop ALL \
  --security-opt no-new-privileges:true \
  -p 8023:8080 \
  prplanit/fairer-pages:latest
```
