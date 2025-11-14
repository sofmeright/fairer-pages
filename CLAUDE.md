# Fairer Pages - Project Instructions

## Non-Negotiable Requirements

### 1. Endpoint Patterns (MUST NOT CHANGE)

#### Playlist Endpoint
```
http://fairer-pages/fairer-pages/playlist/<name>/$status.html
```

Where:
- `<name>` is the playlist name (e.g., work, nature, theatre)
- `$status` is the HTTP error code (e.g., 404, 500, 502)

Examples:
- `http://fairer-pages/fairer-pages/playlist/nature/404.html`
- `http://fairer-pages/fairer-pages/playlist/work/502.html`
- `http://fairer-pages/fairer-pages/playlist/theatre/500.html`

#### Random Endpoint (Default playlist)
```
http://fairer-pages/fairer-pages/random/$status.html
```

Example:
- `http://fairer-pages/fairer-pages/random/404.html`

#### Direct Theme Endpoint
```
http://fairer-pages/fairer-pages/<theme-name>/$status.html
```

Example:
- `http://fairer-pages/fairer-pages/lol-inting/404.html`

### 2. URL Preservation (MUST NOT CHANGE)
**Critical:** The error page MUST be displayed in-place at the same URL where the error was encountered.

- When a user visits `https://example.com/badpage` and gets a 404, the browser URL must remain `https://example.com/badpage`
- The error page content is displayed, but the URL does NOT change
- This ensures the browser's back button works correctly (goes to previous page, not the error handler)

### Implementation Challenge
The reverse proxy calls `/fairer-pages/playlist/nature/404.html` internally, but the browser sees only the original URL (`/badpage`). This means JavaScript in the error page cannot extract the playlist name from `window.location.pathname`.

**Solution needed:** Pass the playlist name from nginx to JavaScript without:
1. Changing the browser's URL (no redirects)
2. Modifying the reverse proxy config
3. Breaking the iframe-based display approach

## Current Implementation

The fairer-pages container uses:
- `random/error.html` as an intermediary that selects a random theme from the playlist
- iframe embedding to preserve the original URL when displaying the selected theme
- `playlist-config.js` loaded at `/fairer-pages/playlist-config.js` containing playlist definitions

## Key Files

- `src/default.conf` - Container nginx configuration
- `src/themes/random/error.html` - Playlist selector page
- `default-playlists.yml` - Source playlist definitions
- `src/entrypoint.sh` - Generates playlist-config.js from YAML

## Testing

Always test with:
```bash
bash src/test-browser.sh
```

This validates JavaScript configuration and playlist setup.

## Docker Build

Build and deploy with:
```bash
docker compose build && docker compose up -d
```
