# Fairer Pages - TODO

## Error Page Preview Gallery (Future Feature)

### Overview
Build an interactive gallery page for previewing all error page themes with keyboard shortcuts, live preview, and dynamic theme discovery.

### Core Functionality

#### Layout
- **Left Panel (60%)**: Large iframe displaying selected error page
- **Right Panel (40%)**: Scrollable theme list with thumbnails/names
- **Top Menu Bar**: Navigation and info

#### Theme Selector
- List view with search/filter
- **Playlist Filter**: Shows only themes from selected playlist (work, nature, theatre)
- Click any theme to load it in the left iframe
- **Keyboard Navigation**:
  - `↑/↓` or `j/k` - Navigate through theme list
  - `1-5` - Select error code (404, 403, 500, 502, 503)
  - Editing text field allows custom error codes (###)
  - `Enter/Space` - Select highlighted theme
  - `` ` `` - Focus search box
  - `Esc` - Clear selection/search

#### URL Display
When a theme is selected, show copyable URLs:
- Direct theme: `/fairer-pages/trollface/404.html`
- Random: `/fairer-pages/random/404.html`
- Playlists: `/fairer-pages/playlist/work/404.html`

#### Error Code Switcher
- Quick buttons at top: `404` `403` `500` `502` `503`
- Instantly reload current theme with different error code
- Shows how theme handles different errors

#### Random Shuffle
- "Random" button to preview random theme
- "Shuffle Playlist" to see random from specific playlist
- Keyboard: `r` for random

#### Theme Info Panel
- Show theme description/personality
- Display which playlists include this theme
- Nginx button causes scroll to the config below

#### Nginx Config Sample
- Beneath the frame if you scroll down
- Sample Nginx block with pre-filled playlist config
- Copy button for quick config

#### Search/Filter
- Search by name, keyword (e.g., "anime", "gaming", "professional")
- Filter by playlist

#### Top Menu Structure
```
[🎨 Fairer Pages]  [Instructions]  [GitHub Icon]  [Search: _____]
```

### Technical Architecture

#### Dynamic Theme Discovery
- **Nginx JSON endpoint**: `/fairer-pages/themes.json`
  - Lists all available themes from `/themes/` directory
  - Dynamically generated (no hardcoding)
- **JavaScript fetches** theme list on page load
- **Future-proof** for:
  - User themes folder (mounted `/user-themes/`)
  - Slim version (downloads themes on demand)
  - Thick version (everything pre-packaged)

#### Files to Create
1. `/gallery.html` - Main preview gallery page
2. `/fairer-pages/themes.json` - Dynamic theme list API (nginx location)
3. Update `/index.html` - Add link to gallery

### Implementation Tasks

- [ ] Create nginx location block to serve theme list as JSON
- [ ] Create gallery.html with responsive layout (60/40 split)
- [ ] Add top menu bar with navigation links
- [ ] Implement left iframe panel for live preview
- [ ] Build right panel theme selector list (populated from JSON)
- [ ] Add keyboard navigation system (j/k, arrows, numbers, etc.)
- [ ] Add error code switcher with quick buttons (404, 403, 500, etc.)
- [ ] Implement search and playlist filter functionality
- [ ] Add URL display panel with copy-to-clipboard buttons
- [ ] Create theme info panel with descriptions
- [ ] Add scrollable nginx config sample section below frame
- [ ] Implement random shuffle button (r key)
- [ ] Update index.html with gallery link
- [ ] Test all keyboard shortcuts work correctly
- [ ] Add mobile-responsive fallback (disable keyboard nav on mobile)

### Why This Is Awesome (But Also 8/10 Overboard)

**Pros:**
- Makes theme discovery/preview delightful
- Shows off the variety and personality of themes
- Encourages community contributions (themes get showcased!)
- Differentiates from boring competitors
- Creates a memorable "experience" not just a tool

**Cons:**
- Way more complex than "just show some error pages"
- Requires maintaining dynamic theme discovery
- Could be a simple README with screenshots

**Verdict:** Ship it anyway because this is what makes projects legendary! 🚀

### Future Enhancements

#### User Themes Support
- Allow mounting `/user-themes/` volume
- Themes in user folder override defaults
- Gallery shows "User" badge on custom themes

#### Slim vs Thick Distribution
- **Slim**: Base container, downloads themes on-demand from CDN/registry
- **Thick**: All 65+ themes pre-packaged (current approach)
- Gallery detects which mode and adjusts UI

#### Theme Marketplace/Registry
- Submit themes via PR
- Automated screenshot generation
- Community voting/ratings
- "Theme of the Month" showcase

#### Comparison Mode
- Split view: compare two themes side-by-side
- Keyboard: `c` for comparison mode
- Useful for picking between similar themes

#### QR Code for Mobile
- Generate QR code for current theme URL
- Easy mobile testing

#### Analytics/Telemetry (Optional)
- Track most popular themes
- Show download counts
- "Trending" section

---

**Note:** This feature is currently documented but not implemented. It's a "nice to have" for making the project more interactive and fun to use!
