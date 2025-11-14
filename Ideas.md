# Fairer Pages - Feature Plans

---

## Back Button Navigation Fix

### User-Facing Documentation

#### Overview
Error pages now properly support browser back button navigation, allowing users to return to the page they were viewing before encountering an error.

#### How It Works

**For Random Error Pages (`/fairer-pages/random/<code>.html`):**
- Random error pages now use iframe to display themed content
- URL stays at `/fairer-pages/random/404.html` (no redirect)
- Browser history: Good Page → Random Error (current)
- Back button: `history.back()` returns to Good Page

**For Direct Theme Error Pages (`/fairer-pages/<theme>/<code>.html`):**
- Direct error pages use browser history navigation
- Browser history: Good Page → Error Page (current)
- Back button: `history.back()` returns to Good Page

### Implementation Plan

#### Phase 1: Random Error Page Iframe Implementation
**File:** `/srv/fairer-pages/src/themes/random/error.html`

**Changes:**
1. Remove redirect logic (lines 302-308)
2. Replace entire page content with minimal iframe wrapper
3. Iframe displays randomly selected theme's error page
4. Add `sandbox="allow-same-origin allow-scripts"` for security
5. No query parameters needed - URL stays clean

**Result:** Random error page stays at same URL, displays themed content via iframe, back button works with `history.back()`

#### Phase 2: Theme Error Page Updates
**Files:** All 63 theme error.html files in `/srv/fairer-pages/src/themes/*/error.html` (excluding random)

**Changes:**
1. Update `goBack()` function to use `history.back()` instead of `document.referrer`
2. Remove query parameter parsing logic (no longer needed)
3. Simplify to single back button implementation

**Old logic (broken by nginx internal redirects):**
```javascript
function goBack() {
    if (document.referrer && document.referrer !== window.location.href) {
        window.location.href = document.referrer;
    } else {
        window.location.href = '/';
    }
}
```

**New logic (works with browser history):**
```javascript
function goBack() {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        window.location.href = '/';
    }
}
```

**Result:** All theme error pages use browser history navigation, back button always works correctly

#### Phase 3: Testing
1. Test random error pages with various error codes (404, 500, 503, etc.)
2. Test direct theme error pages with back button
3. Verify iframe content displays correctly across all themes
4. Test with multiple levels of history (3+ pages deep)
5. Test fallback to homepage when history.length ≤ 1

#### Phase 4: Deployment
1. Build and test locally
2. Commit changes with clean message
3. Tag as new version
4. Push to upstream
5. Deploy to production

---

## Dynamic Playlist Support for Random Error Pages

### User-Facing Documentation

#### Overview
Configure which error page themes display based on URL patterns and environment variables. Perfect for tailoring error page themes to different sites or contexts (work vs personal, funny vs professional).

#### Endpoints

- `/fairer-pages/random/<code>.html` - Uses default playlist + global overrides
- `/fairer-pages/playlist/<name>/<code>.html` - Uses named playlist + global overrides

#### Configuration

##### FAIRER_PLAYLIST_CSV (Simple Mode)
Comma-separated list of themes for the default playlist:

```bash
docker run -e FAIRER_PLAYLIST_CSV="serene-shores,lotus-petal,peaceful-waterfalls" fairer-pages
```

##### FAIRER_PLAYLIST_FILE (Advanced Mode)
Path to YAML file with multiple playlists and per-code overrides. Supports YAML anchors for reusability.

**Example Configuration:**
```yaml
playlists:
  # fpglobal applies to ALL playlists (including default)
  fpglobal:
    ANY: "lol-inting"  # Themes added globally for all error codes
    404: "mk-yoshi-banana, jayandsilentbob"  # Multiple themes added globally for 404s
    406:
      - shadowheart-shar
      - bad-gateway-wag

  # default playlist used by /random/<code>.html
  default:
    ANY: &all-themes
      - back2thefuture
      - MegumiTokoroOwo
      - hideyodawg
      - leggoohno
      - catastrotypcic
      - upsidedown
      - gettodachopper
      - sanfordandson
      - trollface
      - leavealone
      - shaninblake
      - reddressgirl
      - wanderer
      - mk-yoshi-banana
      - strangepresence
      - jayandsilentbob
      - anisorry
      - dogatemypage
      - zelda-mastersword
      - rushhour
      - meninblack
      - bigoneredd
      - fakerockyridge
      - salamancas
      - jessepinkman
      - readyplayerone
      - swordart-aincrad
      - jedi-mindtrick
      - shadowheart-shar
      - rickandmorty
      - shaunofthedead
      - sailormoon
      - psycho-pass
      - still-waiting
      - neighborhood-watch
      - meow-game
      - serene-shores
      - control-room
      - blank-state
      - bridge-rave
      - lotus-petal
      - lol-inting
      - middle-earth-map
      - morrowind-balmora
      - neeko-shapeshifter
      - sun-tzu-chaos
      - vibecoded-trash
      - bad-gateway-wag
      - retrowave-rain
      - shuffled-around
      - star-trek-fuse
      - xbox-bootup
      - zelda-epona
      - zelda-ocarina
      - baldurs-gate-bridge
      - zelda-cozy-hammock
      - zelda-master-sword
      - chill-wallhaven
      - peaceful-waterfalls
      - porco-rosso-pagoda
      - frequency-shift
      - churchill-courage
      - steilacoom-park
      - venn-diagram

  # Named playlists for /playlist/<name>/<code>.html
  work:
    ANY:
      - serene-shores
      - lotus-petal
      - peaceful-waterfalls
      - chill-wallhaven
    404:  # Override work 404s with specific theme
      - neighborhood-watch

  personal:
    ANY: *all-themes  # Reuse all themes anchor

  funny:
    ANY:
      - trollface
      - dogatemypage
      - lol-inting
      - rickandmorty
      - shaunofthedead
```

**Mount the config file:**
```bash
docker run -v /path/to/playlists.yml:/etc/fairer-pages/playlists.yml \
           -e FAIRER_PLAYLIST_FILE=/etc/fairer-pages/playlists.yml \
           fairer-pages
```

#### Selection Logic

1. Parse URL to determine playlist name and error code
2. Load playlist configuration from env var or file
3. Build final theme list:
   - Start with named playlist's themes for that code (or fall back to ANY)
   - Add fpglobal themes for that code (or ANY) if present
4. Select random theme from combined list
5. Display via iframe (keeps URL clean, fixes back button)

**Example:** Request to `/playlist/work/404.html` with above config:
1. Start with `work.404`: `["neighborhood-watch"]`
2. Add `fpglobal.404`: `["mk-yoshi-banana", "jayandsilentbob"]`
3. Final list: `["neighborhood-watch", "mk-yoshi-banana", "jayandsilentbob"]`
4. Select random theme from these three

#### Use Cases

**Corporate/Work Sites:**
```yaml
work:
  ANY:
    - serene-shores
    - peaceful-waterfalls
    - lotus-petal
```
Configure nginx: `error_page 404 /fairer-pages/playlist/work/404.html;`

**Personal Fun Sites:**
```yaml
funny:
  ANY:
    - trollface
    - rickandmorty
    - shaunofthedead
```
Configure nginx: `error_page 404 /fairer-pages/playlist/funny/404.html;`

**Testing Specific Themes:**
```yaml
test-theme:
  ANY: "serene-shores"  # Only show this one theme
```
Visit: `https://example.com/fairer-pages/playlist/test-theme/404.html`

### Implementation Plan

#### Phase 1: Container Entrypoint Script
**File:** `/srv/fairer-pages/entrypoint.sh`

**Responsibilities:**
1. Check for `FAIRER_PLAYLIST_CSV` env var
   - Parse CSV into theme list
   - Generate default playlist config
2. Check for `FAIRER_PLAYLIST_FILE` env var
   - Validate YAML file exists
   - Parse YAML with anchor support
3. Generate JavaScript config file at `/usr/share/nginx/html/playlist-config.js`
4. Start nginx

**Dependencies:**
- `yq` or `python` for YAML parsing (already have python in Alpine)
- Shell scripting for CSV parsing

#### Phase 2: Nginx Configuration Updates
**File:** `/srv/fairer-pages/src/default.conf`

**Changes:**
1. Add location block for `/fairer-pages/playlist/` pattern
2. Rewrite rule to handle `/<playlist-name>/<code>.html` routing
3. Serve from same random/error.html template (differentiate via query param or JS)

**Example nginx config:**
```nginx
location ~ ^/fairer-pages/playlist/([^/]+)/(\d+)\.html$ {
    rewrite ^ /themes/random/$2.html?playlist=$1 last;
}
```

#### Phase 3: Random Error Page JavaScript Updates
**File:** `/srv/fairer-pages/src/themes/random/error.html`

**Changes:**
1. Load `/playlist-config.js` (generated by entrypoint)
2. Parse URL to detect playlist name (query param or path)
3. Implement theme selection logic:
   ```javascript
   function selectTheme(playlistName, errorCode) {
       const config = window.FAIRER_PLAYLISTS || { default: { ANY: [...all themes...] } };
       const playlist = config[playlistName] || config.default;
       const fpglobal = config.fpglobal || {};

       // Get themes for this code, fall back to ANY
       let themes = playlist[errorCode] || playlist.ANY || [];

       // Add global themes for this code
       const globalThemes = fpglobal[errorCode] || fpglobal.ANY || [];
       themes = themes.concat(globalThemes);

       // Select random
       return themes[Math.floor(Math.random() * themes.length)];
   }
   ```
4. Load selected theme in iframe

#### Phase 4: Dockerfile Updates
**File:** `/srv/fairer-pages/Dockerfile`

**Changes:**
1. Install YAML parsing dependencies (`python3`, `py3-yaml`)
2. Copy entrypoint script
3. Set entrypoint: `ENTRYPOINT ["/entrypoint.sh"]`
4. Set CMD: `CMD ["nginx", "-g", "daemon off;"]`

#### Phase 5: Testing Strategy
1. **CSV Mode Testing:**
   - Set `FAIRER_PLAYLIST_CSV` with 3-4 themes
   - Verify only those themes appear on random errors
   - Test multiple error codes (404, 500, 503)

2. **YAML Mode Testing:**
   - Create test YAML with multiple playlists
   - Test named playlists: `/playlist/work/404.html`
   - Test fpglobal overrides
   - Test YAML anchors work correctly
   - Test per-code overrides (404 vs 500)

3. **Edge Cases:**
   - Empty playlist (should fall back to default)
   - Invalid playlist name (should use default)
   - Missing error code in playlist (should use ANY)
   - No fpglobal defined
   - CSV and FILE both set (FILE takes precedence)

4. **Integration Testing:**
   - Deploy behind nginx with various error_page configs
   - Test theme selection across different domains
   - Verify back button still works with all playlist modes

#### Phase 6: Documentation
1. Update README.md with playlist configuration examples
2. Document environment variables
3. Provide example YAML configuration file
4. Add troubleshooting section for common config errors
5. Document YAML anchor usage for DRY configs

### Benefits

- **Flexibility**: Different themes for different sites/contexts
- **Testing**: Easy to preview/test specific themes via custom playlists
- **Organization**: Group themes by mood, style, or purpose
- **DRY**: YAML anchors reduce config duplication
- **Global Overrides**: Force specific themes across all playlists via fpglobal
- **Per-Code Control**: Different themes for 404 vs 500 errors
- **Backwards Compatible**: Works without any env vars (uses all themes as default)
