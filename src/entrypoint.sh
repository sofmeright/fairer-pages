#!/bin/sh
set -e

# Output JavaScript file that will be loaded by random/error.html
OUTPUT_JS="/usr/share/nginx/html/playlist-config.js"
# Default YAML configuration shipped with the container
DEFAULT_PLAYLIST_YAML="/usr/share/nginx/html/default-playlists.yml"

echo "Fairer Pages - Generating playlist configuration..."

# Priority order: FAIRER_PLAYLIST_FILE > FAIRER_PLAYLIST_CSV > default YAML

# Check if custom YAML file is provided via environment variable
if [ -n "$FAIRER_PLAYLIST_FILE" ]; then
    echo "Using custom YAML playlist file: $FAIRER_PLAYLIST_FILE"

    if [ ! -f "$FAIRER_PLAYLIST_FILE" ]; then
        echo "ERROR: Playlist file not found: $FAIRER_PLAYLIST_FILE"
        echo "Falling back to default YAML configuration"
        FAIRER_PLAYLIST_FILE="$DEFAULT_PLAYLIST_YAML"
    fi

    # Convert YAML playlist configuration to browser-ready JavaScript
    python3 - "$FAIRER_PLAYLIST_FILE" > "$OUTPUT_JS" << 'PYTHON_SCRIPT'
import yaml
import json
import sys

try:
    # Load YAML configuration
    with open(sys.argv[1], 'r') as f:
        config = yaml.safe_load(f)

    playlists = config.get('playlists', {})
    js_playlists = {}

    # Convert each playlist to JavaScript-compatible structure
    for playlist_name, playlist_data in playlists.items():
        js_playlists[playlist_name] = {}

        for error_code, themes in playlist_data.items():
            # Support both CSV strings and YAML lists
            if isinstance(themes, str):
                theme_list = [t.strip() for t in themes.split(',')]
            elif isinstance(themes, list):
                theme_list = themes
            else:
                theme_list = []

            js_playlists[playlist_name][error_code] = theme_list

    # Output as JavaScript that assigns to window.FAIRER_PLAYLISTS
    print("window.FAIRER_PLAYLISTS = " + json.dumps(js_playlists, indent=2) + ";")

except Exception as e:
    sys.stderr.write("ERROR parsing YAML: " + str(e) + "\n")
    sys.exit(1)
PYTHON_SCRIPT
fi

# Check if CSV mode is requested
if [ -n "$FAIRER_PLAYLIST_CSV" ]; then
    echo "Using CSV playlist: $FAIRER_PLAYLIST_CSV"

    # Convert CSV to JSON array
    THEMES_JSON=$(echo "$FAIRER_PLAYLIST_CSV" | python3 -c "
import sys
import json
csv = sys.stdin.read().strip()
themes = [t.strip() for t in csv.split(',') if t.strip()]
print(json.dumps(themes))
")

    cat > "$OUTPUT_JS" << EOF
window.FAIRER_PLAYLISTS = {
    "default": {
        "ANY": $THEMES_JSON
    }
};
EOF
fi

# Fallback: use default YAML shipped with container
if [ ! -f "$OUTPUT_JS" ]; then
    echo "Using default YAML playlist configuration"
    python3 - "$DEFAULT_PLAYLIST_YAML" > "$OUTPUT_JS" << 'PYTHON_SCRIPT'
import yaml
import json
import sys

try:
    # Load default YAML configuration
    with open(sys.argv[1], 'r') as f:
        config = yaml.safe_load(f)

    playlists = config.get('playlists', {})
    js_playlists = {}

    # Convert each playlist to JavaScript-compatible structure
    for playlist_name, playlist_data in playlists.items():
        js_playlists[playlist_name] = {}
        for error_code, themes in playlist_data.items():
            # Support both CSV strings and YAML lists
            if isinstance(themes, str):
                theme_list = [t.strip() for t in themes.split(',')]
            elif isinstance(themes, list):
                theme_list = themes
            else:
                theme_list = []
            js_playlists[playlist_name][error_code] = theme_list

    # Output as JavaScript that assigns to window.FAIRER_PLAYLISTS
    print("window.FAIRER_PLAYLISTS = " + json.dumps(js_playlists, indent=2) + ";")

except Exception as e:
    sys.stderr.write("ERROR parsing YAML: " + str(e) + "\n")
    sys.exit(1)
PYTHON_SCRIPT
fi

echo "Playlist configuration generated at $OUTPUT_JS"

# Start nginx
echo "Starting nginx..."
exec nginx -g "daemon off;"
