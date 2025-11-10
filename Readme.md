# Fairer Pages

A containerized error page service supporting multiple themes and error codes.

## Usage

Access error pages via: `http://host:port/<theme>/<errorcode>.html`

### Examples

- `http://localhost/back2thefuture/404.html` - 404 Not Found page
- `http://localhost/back2thefuture/403.html` - 403 Forbidden page
- `http://localhost/back2thefuture/400.html` - 400 Bad Request page

### Supported Error Codes (back2thefuture theme)

- 400 - Bad Request
- 401 - Unauthorized
- 402 - Payment Required
- 403 - Forbidden
- 404 - Not Found
- 405 - Method Not Allowed
- 406 - Not Acceptable

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
