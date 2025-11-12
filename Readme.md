![BANNER](ss/banner.png)

A containerized error page service supporting multiple themes and error codes.

## Public Resources:
|                  |                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------ |
| Docker Images    | [Docker Hub](https://hub.docker.com/r/prplanit/fairer-pages)                         |
| Source Code      | [GitHub](https://github.com/sofmeright/fairer-pages)                                 |
| Theme Gallery    | [Screenshots](https://github.com/sofmeright/fairer-pages/blob/main/themes/Themes.md) |

## Usage

A copy of the instructions/ReadMe is served at the host:port of the docker container by default.

Error pages can be accessed by this syntax:

- `http://<host:port>/fairer-pages/<theme>/<errorcode>.html`
- `http://<domain.tld>/fairer-pages/<theme>/<errorcode>.html`

Examples:

- `http://localhost/fairer-pages/back2thefuture/404.html` - 404 Not Found page
- `http://anchorage:8023/fairer-pages/back2thefuture/403.html` - 403 Forbidden page
- `http://precisionplanit.com/fairer-pages/back2thefuture/400.html` - 400 Bad Request page
- `http://192.168.1.42/fairer-pages/random/404.html` - Random theme for 404 page (picks a different theme each time!)

### Random Theme Selector

> Want to surprise your users? Use the **`random`** theme to automatically pick a different theme each time!

- [Random 404](fairer-pages/random/404.html) - Randomly selects from all available themes
- Works with any error code: [Random 500](fairer-pages/random/500.html), [Random 403](fairer-pages/random/403.html), etc.
- Perfect for keeping error pages fresh and unexpected

#### Overriding the random list to restrict to a custom set of pages:
If you mount `/usr/share/nginx/html/themes/random/error.html` inside the container to local storage...
You should be able to edit the lines that look like this below:

    ```yaml
        <script>
            // All available themes
            const themes = [
                'back2thefuture',
                'MegumiTokoroOwo',
                'hideyodawg',
                'leggoohno',
    ```
                ...
    Edit this list to match the themes you want to be randomly selected and restart the container. 

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

### Available Themes (65+)

All themes support **all HTTP 4xx and 5xx error codes dynamically!** Each theme uses a single dynamic error page that automatically displays the correct error code and message for any HTTP error (400-599).

> Note: The Preview links provided below are **only functional from the WebUI of the docker container**. There's a method to the madness, I promise. 

[Screenshots/Previews are available here without running Fairer Pages!](./Themes.md)

| Theme | Description | 404 | 403 | 500 |
|-------|-------------|-----|-----|-----|
| **anisorry** | Apologetic crying anime girl - "I'm so sorry! Please forgive me!" | [Preview](/fairer-pages/anisorry/404.html) | [Preview](/fairer-pages/anisorry/403.html) | [Preview](/fairer-pages/anisorry/500.html) |
| **back2thefuture** | Retro pixel art style with Back to the Future vibes | [Preview](/fairer-pages/back2thefuture/404.html) | [Preview](/fairer-pages/back2thefuture/403.html) | [Preview](/fairer-pages/back2thefuture/500.html) |
| **bad-gateway-wag** | Finger wagging shame theme - Scolding bad gateways and errors with yellow warning colors and comic style | [Preview](/fairer-pages/bad-gateway-wag/404.html) | [Preview](/fairer-pages/bad-gateway-wag/403.html) | [Preview](/fairer-pages/bad-gateway-wag/500.html) |
| **baldurs-gate-bridge** | D&D/Baldur's Gate 3 theme - Dice rolls, skill checks, narrator text, and fantasy RPG styling | [Preview](/fairer-pages/baldurs-gate-bridge/404.html) | [Preview](/fairer-pages/baldurs-gate-bridge/403.html) | [Preview](/fairer-pages/baldurs-gate-bridge/500.html) |
| **bigoneredd** | Sanford and Son buddy cops - street speak meets tech speak, Redd clutches heart | [Preview](/fairer-pages/bigoneredd/404.html) | [Preview](/fairer-pages/bigoneredd/403.html) | [Preview](/fairer-pages/bigoneredd/500.html) |
| **blank-state** | No Game No Life comfy vibes - Relaxed, casual error messages with purple/pink gradients and warm reassurance | [Preview](/fairer-pages/blank-state/404.html) | [Preview](/fairer-pages/blank-state/403.html) | [Preview](/fairer-pages/blank-state/500.html) |
| **bridge-rave** | Underground renegade rave - Neon colors, disco balls, bass-heavy vibes under the bridge | [Preview](/fairer-pages/bridge-rave/404.html) | [Preview](/fairer-pages/bridge-rave/403.html) | [Preview](/fairer-pages/bridge-rave/500.html) |
| **catastrotypcic** | Matrix terminal with manic cat typing and glitch effects | [Preview](/fairer-pages/catastrotypcic/404.html) | [Preview](/fairer-pages/catastrotypcic/403.html) | [Preview](/fairer-pages/catastrotypcic/500.html) |
| **chill-wallhaven** | Minimalist zen theme - Clean design, breathing exercises, mindful error messages with serene background | [Preview](/fairer-pages/chill-wallhaven/404.html) | [Preview](/fairer-pages/chill-wallhaven/403.html) | [Preview](/fairer-pages/chill-wallhaven/500.html) |
| **churchill-courage** | Churchill wisdom - "Courage to continue" quote with elegant serif typography and golden accents | [Preview](/fairer-pages/churchill-courage/404.html) | [Preview](/fairer-pages/churchill-courage/403.html) | [Preview](/fairer-pages/churchill-courage/500.html) |
| **control-room** | Halo Installation 04 Control Room - 343 Guilty Spark monitor messages with Forerunner holographic terminal and UNSC protocols | [Preview](/fairer-pages/control-room/404.html) | [Preview](/fairer-pages/control-room/403.html) | [Preview](/fairer-pages/control-room/500.html) |
| **dogatemypage** | Robot dog with flamethrower - "My dog ate this page! ¯\_(ツ)_/¯" | [Preview](/fairer-pages/dogatemypage/404.html) | [Preview](/fairer-pages/dogatemypage/403.html) | [Preview](/fairer-pages/dogatemypage/500.html) |
| **fakerockyridge** | Movie set facades - "Oops! Wrong side!" revealing empty scaffolding behind | [Preview](/fairer-pages/fakerockyridge/404.html) | [Preview](/fairer-pages/fakerockyridge/403.html) | [Preview](/fairer-pages/fakerockyridge/500.html) |
| **frequency-shift** | Barbara Marciniak quote - "Emit your own frequency" with purple wave aesthetics and vibration metaphors | [Preview](/fairer-pages/frequency-shift/404.html) | [Preview](/fairer-pages/frequency-shift/403.html) | [Preview](/fairer-pages/frequency-shift/500.html) |
| **gettodachopper** | Arnold action movie extraction - military tactical style | [Preview](/fairer-pages/gettodachopper/404.html) | [Preview](/fairer-pages/gettodachopper/403.html) | [Preview](/fairer-pages/gettodachopper/500.html) |
| **hideyodawg** | Classic "Hide Yo Kids" meme with warning stripes | [Preview](/fairer-pages/hideyodawg/404.html) | [Preview](/fairer-pages/hideyodawg/403.html) | [Preview](/fairer-pages/hideyodawg/500.html) |
| **jayandsilentbob** | 90s video store slacker comedy - hanging outside RST Video | [Preview](/fairer-pages/jayandsilentbob/404.html) | [Preview](/fairer-pages/jayandsilentbob/403.html) | [Preview](/fairer-pages/jayandsilentbob/500.html) |
| **jedi-mindtrick** | Star Wars Jedi mind trick - "This is not the URL you are looking for" with Force waves | [Preview](/fairer-pages/jedi-mindtrick/404.html) | [Preview](/fairer-pages/jedi-mindtrick/403.html) | [Preview](/fairer-pages/jedi-mindtrick/500.html) |
| **jessepinkman** | "Bitch!" appended to everything with chili powder and "Yo, science!" vibes | [Preview](/fairer-pages/jessepinkman/404.html) | [Preview](/fairer-pages/jessepinkman/403.html) | [Preview](/fairer-pages/jessepinkman/500.html) |
| **leavealone** | Leave Britney Alone dramatic emotional meme aesthetic | [Preview](/fairer-pages/leavealone/404.html) | [Preview](/fairer-pages/leavealone/403.html) | [Preview](/fairer-pages/leavealone/500.html) |
| **leggoohno** | Falling waffle with breakfast gradients and syrup drips | [Preview](/fairer-pages/leggoohno/404.html) | [Preview](/fairer-pages/leggoohno/403.html) | [Preview](/fairer-pages/leggoohno/500.html) |
| **lol-inting** | League of Legends toxic ranked experience - 0/10 powerspikes, jg diff, FF @ 15, and authentic LoL flame with KDA displays | [Preview](/fairer-pages/lol-inting/404.html) | [Preview](/fairer-pages/lol-inting/403.html) | [Preview](/fairer-pages/lol-inting/500.html) |
| **lotus-petal** | Zen meditation with snowy mountains - Peaceful, mindful error messages with gentle snowflakes and tranquil lotus symbolism | [Preview](/fairer-pages/lotus-petal/404.html) | [Preview](/fairer-pages/lotus-petal/403.html) | [Preview](/fairer-pages/lotus-petal/500.html) |
| **MegumiTokoroOwo** | Cute anime aesthetic with purple gradients and particles | [Preview](/fairer-pages/MegumiTokoroOwo/404.html) | [Preview](/fairer-pages/MegumiTokoroOwo/403.html) | [Preview](/fairer-pages/MegumiTokoroOwo/500.html) |
| **meninblack** | Neuralyzer memory wipe - "You never saw this page" with classified MIB vibes | [Preview](/fairer-pages/meninblack/404.html) | [Preview](/fairer-pages/meninblack/403.html) | [Preview](/fairer-pages/meninblack/500.html) |
| **meow-game** | Super Troopers meow game - Highway patrol citation with "meow" hidden throughout (includes meow counter!) | [Preview](/fairer-pages/meow-game/404.html) | [Preview](/fairer-pages/meow-game/403.html) | [Preview](/fairer-pages/meow-game/500.html) |
| **middle-earth-map** | Lord of the Rings Middle-earth journey - Ancient maps, Fellowship quotes, and Tolkien's legendary realm | [Preview](/fairer-pages/middle-earth-map/404.html) | [Preview](/fairer-pages/middle-earth-map/403.html) | [Preview](/fairer-pages/middle-earth-map/500.html) |
| **mk-yoshi-banana** | Mario Kart banana slip - Yoshi racing with banana peel hazards | [Preview](/fairer-pages/mk-yoshi-banana/404.html) | [Preview](/fairer-pages/mk-yoshi-banana/403.html) | [Preview](/fairer-pages/mk-yoshi-banana/500.html) |
| **morrowind-balmora** | Elder Scrolls Morrowind - Journal entries from Vvardenfell with Balmora backdrop and Nerevarine vibes | [Preview](/fairer-pages/morrowind-balmora/404.html) | [Preview](/fairer-pages/morrowind-balmora/403.html) | [Preview](/fairer-pages/morrowind-balmora/500.html) |
| **neeko-shapeshifter** | Neeko the chameleon from LoL - Colorful, playful shapeshifting errors with "Neeko is strong tomato!" personality | [Preview](/fairer-pages/neeko-shapeshifter/404.html) | [Preview](/fairer-pages/neeko-shapeshifter/403.html) | [Preview](/fairer-pages/neeko-shapeshifter/500.html) |
| **neighborhood-watch** | The Watch collateral damage - "Good news: threat eliminated. Bad news: we destroyed everything 🤷" with Costco and alien orb | [Preview](/fairer-pages/neighborhood-watch/404.html) | [Preview](/fairer-pages/neighborhood-watch/403.html) | [Preview](/fairer-pages/neighborhood-watch/500.html) |
| **peaceful-waterfalls** | Nature water metaphors - Flow and stream language with calming waterfall imagery and natural wisdom | [Preview](/fairer-pages/peaceful-waterfalls/404.html) | [Preview](/fairer-pages/peaceful-waterfalls/403.html) | [Preview](/fairer-pages/peaceful-waterfalls/500.html) |
| **porco-rosso-pagoda** | Lush, relaxed pagoda theme - Elegant serif typography with muted golden-brown tones and tranquil backdrop | [Preview](/fairer-pages/porco-rosso-pagoda/404.html) | [Preview](/fairer-pages/porco-rosso-pagoda/403.html) | [Preview](/fairer-pages/porco-rosso-pagoda/500.html) |
| **psycho-pass** | Sibyl System crime coefficient scanner - Dominator enforcement mode with cyberpunk holographic UI | [Preview](/fairer-pages/psycho-pass/404.html) | [Preview](/fairer-pages/psycho-pass/403.html) | [Preview](/fairer-pages/psycho-pass/500.html) |
| **readyplayerone** | Ready Player One OASIS terminal with neon cyberpunk and Halliday's Journal quotes | [Preview](/fairer-pages/readyplayerone/404.html) | [Preview](/fairer-pages/readyplayerone/403.html) | [Preview](/fairer-pages/readyplayerone/500.html) |
| **reddressgirl** | Distracted boyfriend meme - caught looking at the wrong page | [Preview](/fairer-pages/reddressgirl/404.html) | [Preview](/fairer-pages/reddressgirl/403.html) | [Preview](/fairer-pages/reddressgirl/500.html) |
| **retrowave-rain** | Synthwave aesthetic - Neon pink/cyan with rainy pixel art background, scanlines, and chill vibes | [Preview](/fairer-pages/retrowave-rain/404.html) | [Preview](/fairer-pages/retrowave-rain/403.html) | [Preview](/fairer-pages/retrowave-rain/500.html) |
| **rickandmorty** | Rick mocks human error systems while Morty nervously tries to explain what went wrong | [Preview](/fairer-pages/rickandmorty/404.html) | [Preview](/fairer-pages/rickandmorty/403.html) | [Preview](/fairer-pages/rickandmorty/500.html) |
| **rushhour** | Action buddy cop comedy - "Do you understand this error message?" | [Preview](/fairer-pages/rushhour/404.html) | [Preview](/fairer-pages/rushhour/403.html) | [Preview](/fairer-pages/rushhour/500.html) |
| **sailormoon** | Sailor Moon magical girl transformation - "In the name of the moon, I'll punish this error!" with attack names | [Preview](/fairer-pages/sailormoon/404.html) | [Preview](/fairer-pages/sailormoon/403.html) | [Preview](/fairer-pages/sailormoon/500.html) |
| **salamancas** | Breaking Bad cartel territory - "You're on the wrong turf, ese" dangerous vibes | [Preview](/fairer-pages/salamancas/404.html) | [Preview](/fairer-pages/salamancas/403.html) | [Preview](/fairer-pages/salamancas/500.html) |
| **sanfordandson** | 1970s Sanford & Son junkyard salvage with Fred's classic lines | [Preview](/fairer-pages/sanfordandson/404.html) | [Preview](/fairer-pages/sanfordandson/403.html) | [Preview](/fairer-pages/sanfordandson/500.html) |
| **serene-shores** | Calming beach sunset - Professional, soothing error messages with elegant typography and peaceful ocean metaphors | [Preview](/fairer-pages/serene-shores/404.html) | [Preview](/fairer-pages/serene-shores/403.html) | [Preview](/fairer-pages/serene-shores/500.html) |
| **shadowheart-shar** | Baldur's Gate 3 Shadowheart - Lady Shar's darkness vs inner light, embrace loss or seek hope | [Preview](/fairer-pages/shadowheart-shar/404.html) | [Preview](/fairer-pages/shadowheart-shar/403.html) | [Preview](/fairer-pages/shadowheart-shar/500.html) |
| **shaninblake** | Pastel 70s manifestation and spiritual vibes with floral particles | [Preview](/fairer-pages/shaninblake/404.html) | [Preview](/fairer-pages/shaninblake/403.html) | [Preview](/fairer-pages/shaninblake/500.html) |
| **shaunofthedead** | British zombie apocalypse humor - "You've got red on you" with plans to head to the Winchester | [Preview](/fairer-pages/shaunofthedead/404.html) | [Preview](/fairer-pages/shaunofthedead/403.html) | [Preview](/fairer-pages/shaunofthedead/500.html) |
| **shuffled-around** | Disco house music rave culture - 135 BPM, cutting shapes, "Sorry, I got carried away shuffling things around" with neon vibes | [Preview](/fairer-pages/shuffled-around/404.html) | [Preview](/fairer-pages/shuffled-around/403.html) | [Preview](/fairer-pages/shuffled-around/500.html) |
| **star-trek-fuse** | Star Trek LCARS technical malfunction - Blown fuse, system failure, Starfleet emergency protocols | [Preview](/fairer-pages/star-trek-fuse/404.html) | [Preview](/fairer-pages/star-trek-fuse/403.html) | [Preview](/fairer-pages/star-trek-fuse/500.html) |
| **steilacoom-park** | Tranquil park nature theme - Peaceful forest trails with green tones and nature wisdom metaphors | [Preview](/fairer-pages/steilacoom-park/404.html) | [Preview](/fairer-pages/steilacoom-park/403.html) | [Preview](/fairer-pages/steilacoom-park/500.html) |
| **still-waiting** | Matrix Construct white void - "Stop trying to find it and realize... there is no page" with Morpheus wisdom | [Preview](/fairer-pages/still-waiting/404.html) | [Preview](/fairer-pages/still-waiting/403.html) | [Preview](/fairer-pages/still-waiting/500.html) |
| **strangepresence** | Supernatural séance - "We sense a presence... something will happen soon" | [Preview](/fairer-pages/strangepresence/404.html) | [Preview](/fairer-pages/strangepresence/403.html) | [Preview](/fairer-pages/strangepresence/500.html) |
| **sun-tzu-chaos** | Art of War wisdom - "In the midst of chaos, there is also opportunity" with ancient strategic philosophy | [Preview](/fairer-pages/sun-tzu-chaos/404.html) | [Preview](/fairer-pages/sun-tzu-chaos/403.html) | [Preview](/fairer-pages/sun-tzu-chaos/500.html) |
| **swordart-aincrad** | Sword Art Online Aincrad - "At least you won't die" with HP bars and floor system | [Preview](/fairer-pages/swordart-aincrad/404.html) | [Preview](/fairer-pages/swordart-aincrad/403.html) | [Preview](/fairer-pages/swordart-aincrad/500.html) |
| **trollface** | Classic rage comic internet meme - "Problem?" | [Preview](/fairer-pages/trollface/404.html) | [Preview](/fairer-pages/trollface/403.html) | [Preview](/fairer-pages/trollface/500.html) |
| **upsidedown** | Stranger Things Upside Down with flickering lights | [Preview](/fairer-pages/upsidedown/404.html) | [Preview](/fairer-pages/upsidedown/403.html) | [Preview](/fairer-pages/upsidedown/500.html) |
| **venn-diagram** | Animated Venn diagram - Colorful overlapping circles with dynamic error-specific messaging and gradients | [Preview](/fairer-pages/venn-diagram/404.html) | [Preview](/fairer-pages/venn-diagram/403.html) | [Preview](/fairer-pages/venn-diagram/500.html) |
| **vibecoded-trash** | Claude Code self-roast - Terminal chat between admin and Claude troubleshooting errors with hilarious self-awareness | [Preview](/fairer-pages/vibecoded-trash/404.html) | [Preview](/fairer-pages/vibecoded-trash/403.html) | [Preview](/fairer-pages/vibecoded-trash/500.html) |
| **wanderer** | Tolkien-inspired fantasy journey - "Not all who wander are lost, but you are!" | [Preview](/fairer-pages/wanderer/404.html) | [Preview](/fairer-pages/wanderer/403.html) | [Preview](/fairer-pages/wanderer/500.html) |
| **xbox-bootup** | Xbox console experience - Green glow, loading bar animations, and console-style status messages | [Preview](/fairer-pages/xbox-bootup/404.html) | [Preview](/fairer-pages/xbox-bootup/403.html) | [Preview](/fairer-pages/xbox-bootup/500.html) |
| **zelda-cozy-hammock** | Relaxed cozy Zelda theme - Link chilling in hammock with calming green tones and no-rush messaging | [Preview](/fairer-pages/zelda-cozy-hammock/404.html) | [Preview](/fairer-pages/zelda-cozy-hammock/403.html) | [Preview](/fairer-pages/zelda-cozy-hammock/500.html) |
| **zelda-epona** | Zelda riding Epona across Hyrule - Minimal text, let the journey speak, galloping through fields | [Preview](/fairer-pages/zelda-epona/404.html) | [Preview](/fairer-pages/zelda-epona/403.html) | [Preview](/fairer-pages/zelda-epona/500.html) |
| **zelda-master-sword** | Heroic Master Sword theme - Courage and trials with blue/white glowing sword aesthetic and hero's journey | [Preview](/fairer-pages/zelda-master-sword/404.html) | [Preview](/fairer-pages/zelda-master-sword/403.html) | [Preview](/fairer-pages/zelda-master-sword/500.html) |
| **zelda-mastersword** | Legend of Zelda adventure - "It's dangerous to go alone!" with Master Sword | [Preview](/fairer-pages/zelda-mastersword/404.html) | [Preview](/fairer-pages/zelda-mastersword/403.html) | [Preview](/fairer-pages/zelda-mastersword/500.html) |
| **zelda-ocarina** | Ocarina of Time theme - Triforce symbol, golden colors, quest messages, and songs for each error | [Preview](/fairer-pages/zelda-ocarina/404.html) | [Preview](/fairer-pages/zelda-ocarina/403.html) | [Preview](/fairer-pages/zelda-ocarina/500.html) |

## Installation

The recommended path is a **Docker** or Kubernetes based deploment of Fairer Pages. 
> This project is near 100% HTML & JS, it should not be dependent on Docker/K8s, let alone NGINX. Feel free to explore this.

Docker Compose Example:
```yaml
services:
  fairer-pages:
    container_name: fairer-pages
    image: prplanit/fairer-pages:latest
    ports: 
      - 8023:80
```

Docker Run Example:
```bash
 docker run -d --name fairer-pages --restart always -p 8023:80 prplanit/fairer-pages:latest
```

## Nginx Integration Example:

```nginx
# Define your Fairer Pages Upstream:
upstream fairer-pages { 
    server fairer-pages-host:8023; 
}

server {
    server_name domain.com;

    # Directs the server to listen for IPv4 connections on port 80.
    listen 80;
    # Directs the server to listen for IPv6 connections on port 80.
    listen [::]:80;
    # Redirect all requests from this listener, 80 -> 443 (HTTP -> HTTPS).
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name domain.com;

    ssl_certificate /etc/letsencrypt/live/domain.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/domain.com/privkey.pem; # managed by Certbot
    ssl_dhparam /etc/nginx/ssl/dhparam.pem;

    ssl_protocols TLSv1.1 TLSv1.2;
    ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
    ssl_prefer_server_ciphers on;
    #ssl_session_cache shared:SSL:10m;

    # You can configure specific paths and (sub)domains to only serve 404's with NGINX.
    # If you desire that behavior; uncomment the `return` line below and remove/comment the `proxy_pass` and configure the rest as desired.
    # Otherwise this block would serve http://some-important-service:port to clients of domain.com with fairer pages via fairer-pages-host:8023.
    location / {
        # return 404;
        proxy_pass http://some-important-service:port/;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Enable error interception
    proxy_intercept_errors on;

    # Route errors to fairer-pages service
    error_page 400 401 402 403 404 405 406 408 409 410 413 429 500 502 503 504 = @error_handler;

    # Proxy fairer-pages "/fairer-pages/" path, so error pages can be available available to clients!
    location /fairer-pages/ {
        proxy_pass http://fairer-pages/fairer-pages/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Define the error handler and select your **error theme** in the **proxy-pass**.
    location @error_handler {
        proxy_pass http://fairer-pages/fairer-pages/random/$status.html;
        proxy_set_header Host $host;
        internal;

        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## Building Fairer Pages from Source:

```bash
# Navigate to a suitable folder to clone the repo:
cd /srv
# Clone the Repository and `cd` into it:
git clone https://github.com/sofmeright/fairer-pages && cd fairer-pages
# Build Fairer Pages:
docker build -t fairer-pages .
# Run Fairer Pages:
docker run -d -p 8023:80 fairer-pages
# Run a Quick Test:
curl http://localhost:8023/back2thefuture/404.html
```

## Adding More Themes:

1. Create a new directory under `themes/`.
2. Add error HTML files (400.html, 403.html, 404.html, etc.).
3. Add theme resources in `themes/<theme>/resources/`.
4. Follow the steps provided above to build the image with your modifications.

---

## Contributing
- File issues with steps, logs, and versions.
- Small, focused PRs are best (typos, error handling, UI polish).
- Theme contributions are welcome!
- Security-related PRs and hardening suggestions are especially appreciated if you notice anything that can be improved.

## Support / Sponsorship
If you’d like to help support this project and others like it, I have this donation link:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/T6T41IT163)

---

## Disclaimer

The Software provided hereunder ("Software") is licensed "as‑is," without warranties of any kind—express, implied, or whispered by mystical wisps. The Softwarer (yes, that's totally a word now) makes no promises about functionality, performance, compatibility, security, or availability—and absolutely no warranty of any sort. The developer shall not be held responsible, even if the software is clearly the reason your 404 page became more entertaining than your actual content, your users spent three hours clicking through every theme instead of buying anything, or your error pages gained sentience and started redirecting to Rick Astley videos.

If using this error page collection leads you down a rabbit hole of obsessive theme customization, breaks your carefully crafted nginx configs, or causes an uprising among your regex location blocks—sorry, still not liable. Also not liable if your random theme selector becomes so addictive it crashes your analytics or if your resource paths multiply like lightning bolts in a DeLorean. The developer likewise claims no credit for anything that actually goes right either. Any positive experiences are owed entirely to the unstoppable force that is the Open Source community.

Just don't blame me when your creative ways to cause errors in your environment for "testing" purposes inevitably backfires.