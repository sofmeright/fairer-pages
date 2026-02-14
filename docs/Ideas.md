# Fairer Pages - Feature Ideas

## Status

Fairer Pages is at MVP+ as of v0.0.14. The core feature set is complete and fully functional — themed error pages served via playlists, mobile-responsive viewport scaling, in-place iframe error serving, and a library of 65+ themes. Beyond the ideas below, the only other direction would be a Go rewrite for feature parity. This project is effectively in minimal maintenance mode.

## Dynamic Theme Viewer / Playground

A built-in web UI that ships with the container, serving as both a demo and management tool:

- **Theme Preview**: Browse all available themes (bundled + user-mounted) in a live preview where you can try each error page and see what they look like across different error codes
- **Playlist Editor**: Visual interface for creating and editing playlists — drag-and-drop theme ordering, enable/disable individual themes, export as CSV or YAML
- **Theme Wizard**: A guided builder for creating simple custom themes by snapping in images, text, fonts, and color schemes without writing HTML/CSS — basically a form that populates `theme.json` and `theme.css` for the template system

## Go Rewrite

Port the project from nginx/Lua to Go for a single static binary, potentially with embedded templates. Would achieve feature parity with the current implementation while simplifying deployment and reducing the container footprint.
