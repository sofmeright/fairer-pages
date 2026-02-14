# Playlists - Curated Theme Collections

> Create custom theme collections for different contexts! Use playlists to group themes by mood, purpose, or audience.

The playlist endpoint allows you to randomly select from a curated subset of themes:

```
http://<host:port>/fairer-pages/playlist/<playlist-name>/<errorcode>.html
```

Examples:
- `http://localhost/fairer-pages/playlist/work/404.html` - Professional themes suitable for work environments
- `http://anchorage:8023/fairer-pages/playlist/nature/500.html` - Calming nature-themed error pages
- `http://precisionplanit.com/fairer-pages/playlist/theatre/403.html` - Dramatic theatrical themes

## Built-in Playlists

The default configuration includes several pre-configured playlists:

- **work** - Professional, calming themes suitable for business contexts
- **nature** - Peaceful, natural themes (lotus-petal, peaceful-waterfalls, serene-shores, etc.)
- **theatre** - Dramatic, entertaining themes with pop culture references
- **pretty-shiny** - Visually appealing, polished themes
- **default** - All available themes (same as `/random/`)

See [default-playlists.yml](../../default-playlists.yml) for the full default configuration.

## Custom Playlists

You can define your own playlists using environment variables:

**Option 1: CSV (Simple)**
```bash
docker run -e FAIRER_PLAYLIST_CSV="trollface,blank-state,dogatemypage" prplanit/fairer-pages
```

**Option 2: YAML File (Advanced)**
```yaml
# custom-playlists.yml
playlists:
  my-playlist:
    ANY:
      - trollface
      - sailormoon
      - rickandmorty

  corporate:
    ANY:
      - churchill-courage
      - jedi-mindtrick
      - sun-tzu-chaos
```

```bash
docker run -e FAIRER_PLAYLIST_FILE=/path/to/custom-playlists.yml \
  -v /path/to/custom-playlists.yml:/path/to/custom-playlists.yml:ro \
  prplanit/fairer-pages
```
