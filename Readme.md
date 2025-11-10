# Fairer Pages

A containerized error page service supporting multiple themes and error codes.

## Usage

Access error pages via: `http://host:port/<theme>/<errorcode>.html`

### Examples

- `http://localhost/back2thefuture/404.html` - 404 Not Found page
- `http://localhost/back2thefuture/403.html` - 403 Forbidden page
- `http://localhost/back2thefuture/400.html` - 400 Bad Request page

### Available Themes

All themes support **all HTTP 4xx and 5xx error codes dynamically!** Each theme uses a single dynamic error page that automatically displays the correct error code and message for any HTTP error (400-599).

| Theme | Description | 404 | 403 | 500 |
|-------|-------------|-----|-----|-----|
| **back2thefuture** | Retro pixel art style with Back to the Future vibes | [Preview](/back2thefuture/404.html) | [Preview](/back2thefuture/403.html) | [Preview](/back2thefuture/500.html) |
| **MegumiTokoroOwo** | Cute anime aesthetic with purple gradients and particles | [Preview](/MegumiTokoroOwo/404.html) | [Preview](/MegumiTokoroOwo/403.html) | [Preview](/MegumiTokoroOwo/500.html) |
| **hideyodawg** | Classic "Hide Yo Kids" meme with warning stripes | [Preview](/hideyodawg/404.html) | [Preview](/hideyodawg/403.html) | [Preview](/hideyodawg/500.html) |
| **leggoohno** | Falling waffle with breakfast gradients and syrup drips | [Preview](/leggoohno/404.html) | [Preview](/leggoohno/403.html) | [Preview](/leggoohno/500.html) |
| **catastrotypcic** | Matrix terminal with manic cat typing and glitch effects | [Preview](/catastrotypcic/404.html) | [Preview](/catastrotypcic/403.html) | [Preview](/catastrotypcic/500.html) |
| **upsidedown** | Stranger Things Upside Down with flickering lights | [Preview](/upsidedown/404.html) | [Preview](/upsidedown/403.html) | [Preview](/upsidedown/500.html) |
| **gettodachopper** | Arnold action movie extraction - military tactical style | [Preview](/gettodachopper/404.html) | [Preview](/gettodachopper/403.html) | [Preview](/gettodachopper/500.html) |
| **sanfordandson** | 1970s Sanford & Son junkyard salvage with Fred's classic lines | [Preview](/sanfordandson/404.html) | [Preview](/sanfordandson/403.html) | [Preview](/sanfordandson/500.html) |
| **trollface** | Classic rage comic internet meme - "Problem?" | [Preview](/trollface/404.html) | [Preview](/trollface/403.html) | [Preview](/trollface/500.html) |
| **leavealone** | Leave Britney Alone dramatic emotional meme aesthetic | [Preview](/leavealone/404.html) | [Preview](/leavealone/403.html) | [Preview](/leavealone/500.html) |
| **shaninblake** | Pastel 70s manifestation and spiritual vibes with floral particles | [Preview](/shaninblake/404.html) | [Preview](/shaninblake/403.html) | [Preview](/shaninblake/500.html) |
| **reddressgirl** | Distracted boyfriend meme - caught looking at the wrong page | [Preview](/reddressgirl/404.html) | [Preview](/reddressgirl/403.html) | [Preview](/reddressgirl/500.html) |
| **wanderer** | Tolkien-inspired fantasy journey - "Not all who wander are lost, but you are!" | [Preview](/wanderer/404.html) | [Preview](/wanderer/403.html) | [Preview](/wanderer/500.html) |
| **mk-yoshi-banana** | Mario Kart banana slip - Yoshi racing with banana peel hazards | [Preview](/mk-yoshi-banana/404.html) | [Preview](/mk-yoshi-banana/403.html) | [Preview](/mk-yoshi-banana/500.html) |

### Supported Error Codes

Common error codes (all supported):
- 400 - Bad Request
- 401 - Unauthorized
- 403 - Forbidden
- 404 - Not Found
- 405 - Method Not Allowed
- 429 - Too Many Requests
- 500 - Internal Server Error
- 502 - Bad Gateway
- 503 - Service Unavailable

...and many more (all 4xx and 5xx codes)!

## Integration with Nginx

```nginx
server {
    listen 443 ssl;
    server_name example.com;

    # Enable error interception
    proxy_intercept_errors on;

    # Your normal configuration
    location / {
        proxy_pass http://backend;
    }

    # Route errors to fairer-pages service
    error_page 400 401 402 403 404 405 406 = @error_handler;

    location @error_handler {
        proxy_pass http://fairer-pages/back2thefuture/$status.html;
        proxy_set_header Host $host;
        internal;
    }
}

upstream fairer-pages {
    server fairer-pages:80;
}
```

## Adding New Themes

1. Create a new directory under `themes/`
2. Add error HTML files (400.html, 403.html, 404.html, etc.)
3. Add theme resources in `themes/<theme>/resources/`
4. Commit and push - CI/CD will build and deploy automatically

## Local Testing

```bash
docker build -t fairer-pages-test .
docker run -d -p 8080:80 fairer-pages-test
curl http://localhost:8080/back2thefuture/404.html
```
