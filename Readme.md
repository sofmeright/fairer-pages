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

#### 1. **back2thefuture** - Retro Pixel Art
Classic 80s pixel art style with Back to the Future vibes. Features the DeLorean and retro gaming aesthetics.

**Preview:**
- [404 Error](/back2thefuture/404.html)
- [403 Forbidden](/back2thefuture/403.html)
- [500 Internal Server Error](/back2thefuture/500.html)

#### 2. **MegumiTokoroOwo** - Cute Anime Style
Beautiful anime aesthetic with Megumi Tokoro artwork, purple gradients, and floating particle effects.

**Preview:**
- [404 Error](/MegumiTokoroOwo/404.html)
- [403 Forbidden](/MegumiTokoroOwo/403.html)
- [500 Internal Server Error](/MegumiTokoroOwo/500.html)

#### 3. **hideyodawg** - Classic Warning Meme
Antoine Dodson "Hide Yo Kids, Hide Yo Wife" meme style with warning stripes and bold Impact font.

**Preview:**
- [404 Error](/hideyodawg/404.html)
- [403 Forbidden](/hideyodawg/403.html)
- [500 Internal Server Error](/hideyodawg/500.html)

#### 4. **leggoohno** - Breakfast Waffle Chaos
Falling waffle with golden breakfast gradients, syrup drips, and Bangers font for that cereal box energy.

**Preview:**
- [404 Error](/leggoohno/404.html)
- [403 Forbidden](/leggoohno/403.html)
- [500 Internal Server Error](/leggoohno/500.html)

#### 5. **catastrotypcic** - Manic Terminal Cat
Matrix-style terminal with a cat typing frantically, glitch effects, and falling code rain.

**Preview:**
- [404 Error](/catastrotypcic/404.html)
- [403 Forbidden](/catastrotypcic/403.html)
- [500 Internal Server Error](/catastrotypcic/500.html)

#### 6. **upsidedown** - Stranger Things Atmosphere
Eerie Upside Down dimension from Stranger Things with flickering lights, floating spores, and dark atmosphere.

**Preview:**
- [404 Error](/upsidedown/404.html)
- [403 Forbidden](/upsidedown/403.html)
- [500 Internal Server Error](/upsidedown/500.html)

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
