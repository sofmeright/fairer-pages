# Nginx Integration

Use Fairer Pages as an error page backend for your nginx reverse proxy. Nginx intercepts upstream errors and serves themed error pages while preserving the original URL in the browser.

## How It Works

1. Client requests a page from your domain
2. Nginx proxies to the upstream application
3. If the upstream returns an error (4xx/5xx), `proxy_intercept_errors` catches it
4. The `error_page` directive routes to the `@error_handler` location
5. `@error_handler` fetches the themed error page from the fairer-pages container
6. The browser URL stays unchanged — the error page is served in-place

## Example Configs

| File | Description |
|------|-------------|
| [fairer-pages.conf](fairer-pages.conf) | Single-domain setup with SSL and error interception |
| [fairer-pages-multi-domain.conf](fairer-pages-multi-domain.conf) | Multiple domains with per-domain playlist selection via `map` |

## Theme Selection

Change the `proxy_pass` in `@error_handler` to use different theme strategies:

- **Random** — `proxy_pass http://fairer-pages/fairer-pages/random/$status.html;`
- **Specific theme** — `proxy_pass http://fairer-pages/fairer-pages/back2thefuture/$status.html;`
- **Named playlist** — `proxy_pass http://fairer-pages/fairer-pages/playlist/work/$status.html;`
