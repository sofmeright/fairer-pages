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
| **strangepresence** | Supernatural séance - "We sense a presence... something will happen soon" | [Preview](/strangepresence/404.html) | [Preview](/strangepresence/403.html) | [Preview](/strangepresence/500.html) |
| **jayandsilentbob** | 90s video store slacker comedy - hanging outside RST Video | [Preview](/jayandsilentbob/404.html) | [Preview](/jayandsilentbob/403.html) | [Preview](/jayandsilentbob/500.html) |
| **anisorry** | Apologetic crying anime girl - "I'm so sorry! Please forgive me!" | [Preview](/anisorry/404.html) | [Preview](/anisorry/403.html) | [Preview](/anisorry/500.html) |
| **dogatemypage** | Robot dog with flamethrower - "My dog ate this page! ¯\_(ツ)_/¯" | [Preview](/dogatemypage/404.html) | [Preview](/dogatemypage/403.html) | [Preview](/dogatemypage/500.html) |
| **zelda-mastersword** | Legend of Zelda adventure - "It's dangerous to go alone!" with Master Sword | [Preview](/zelda-mastersword/404.html) | [Preview](/zelda-mastersword/403.html) | [Preview](/zelda-mastersword/500.html) |
| **rushhour** | Action buddy cop comedy - "Do you understand this error message?" | [Preview](/rushhour/404.html) | [Preview](/rushhour/403.html) | [Preview](/rushhour/500.html) |
| **meninblack** | Neuralyzer memory wipe - "You never saw this page" with classified MIB vibes | [Preview](/meninblack/404.html) | [Preview](/meninblack/403.html) | [Preview](/meninblack/500.html) |
| **bigoneredd** | Sanford and Son buddy cops - street speak meets tech speak, Redd clutches heart | [Preview](/bigoneredd/404.html) | [Preview](/bigoneredd/403.html) | [Preview](/bigoneredd/500.html) |
| **fakerockyridge** | Movie set facades - "Oops! Wrong side!" revealing empty scaffolding behind | [Preview](/fakerockyridge/404.html) | [Preview](/fakerockyridge/403.html) | [Preview](/fakerockyridge/500.html) |
| **salamancas** | Breaking Bad cartel territory - "You're on the wrong turf, ese" dangerous vibes | [Preview](/salamancas/404.html) | [Preview](/salamancas/403.html) | [Preview](/salamancas/500.html) |
| **jessepinkman** | "Bitch!" appended to everything with chili powder and "Yo, science!" vibes | [Preview](/jessepinkman/404.html) | [Preview](/jessepinkman/403.html) | [Preview](/jessepinkman/500.html) |
| **readyplayerone** | Ready Player One OASIS terminal with neon cyberpunk and Halliday's Journal quotes | [Preview](/readyplayerone/404.html) | [Preview](/readyplayerone/403.html) | [Preview](/readyplayerone/500.html) |
| **swordart-aincrad** | Sword Art Online Aincrad - "At least you won't die" with HP bars and floor system | [Preview](/swordart-aincrad/404.html) | [Preview](/swordart-aincrad/403.html) | [Preview](/swordart-aincrad/500.html) |
| **jedi-mindtrick** | Star Wars Jedi mind trick - "This is not the URL you are looking for" with Force waves | [Preview](/jedi-mindtrick/404.html) | [Preview](/jedi-mindtrick/403.html) | [Preview](/jedi-mindtrick/500.html) |
| **shadowheart-shar** | Baldur's Gate 3 Shadowheart - Lady Shar's darkness vs inner light, embrace loss or seek hope | [Preview](/shadowheart-shar/404.html) | [Preview](/shadowheart-shar/403.html) | [Preview](/shadowheart-shar/500.html) |
| **rickandmorty** | Rick mocks human error systems while Morty nervously tries to explain what went wrong | [Preview](/rickandmorty/404.html) | [Preview](/rickandmorty/403.html) | [Preview](/rickandmorty/500.html) |
| **shaunofthedead** | British zombie apocalypse humor - "You've got red on you" with plans to head to the Winchester | [Preview](/shaunofthedead/404.html) | [Preview](/shaunofthedead/403.html) | [Preview](/shaunofthedead/500.html) |
| **sailormoon** | Sailor Moon magical girl transformation - "In the name of the moon, I'll punish this error!" with attack names | [Preview](/sailormoon/404.html) | [Preview](/sailormoon/403.html) | [Preview](/sailormoon/500.html) |
| **psycho-pass** | Sibyl System crime coefficient scanner - Dominator enforcement mode with cyberpunk holographic UI | [Preview](/psycho-pass/404.html) | [Preview](/psycho-pass/403.html) | [Preview](/psycho-pass/500.html) |
| **still-waiting** | Matrix Construct white void - "Stop trying to find it and realize... there is no page" with Morpheus wisdom | [Preview](/still-waiting/404.html) | [Preview](/still-waiting/403.html) | [Preview](/still-waiting/500.html) |
| **neighborhood-watch** | The Watch collateral damage - "Good news: threat eliminated. Bad news: we destroyed everything 🤷" with Costco and alien orb | [Preview](/neighborhood-watch/404.html) | [Preview](/neighborhood-watch/403.html) | [Preview](/neighborhood-watch/500.html) |
| **meow-game** | Super Troopers meow game - Highway patrol citation with "meow" hidden throughout (includes meow counter!) | [Preview](/meow-game/404.html) | [Preview](/meow-game/403.html) | [Preview](/meow-game/500.html) |

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
