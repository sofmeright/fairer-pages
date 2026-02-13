#!/bin/sh
set -e

# --- Environment defaults ---
export LISTEN_PORT="${LISTEN_PORT:-8080}"
export LOG_LEVEL="${LOG_LEVEL:-warn}"
export WORKER_PROCESSES="${WORKER_PROCESSES:-auto}"

# --- Resolve nginx config templates into /tmp (read-only root filesystem) ---
mkdir -p /tmp/conf.d

envsubst '${LISTEN_PORT}' \
  < /etc/nginx/conf.d/default.conf.template \
  > /tmp/conf.d/default.conf

envsubst '${WORKER_PROCESSES} ${LOG_LEVEL}' \
  < /etc/nginx/nginx.conf.template \
  > /tmp/nginx.conf

# --- Generate playlist configuration ---
OUTPUT_JS="/tmp/playlist-config.js"
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

    python3 - "$FAIRER_PLAYLIST_FILE" > "$OUTPUT_JS" << 'PYTHON_SCRIPT'
import yaml
import json
import sys

try:
    with open(sys.argv[1], 'r') as f:
        config = yaml.safe_load(f)

    playlists = config.get('playlists', {})
    js_playlists = {}

    for playlist_name, playlist_data in playlists.items():
        js_playlists[playlist_name] = {}

        for error_code, themes in playlist_data.items():
            if isinstance(themes, str):
                theme_list = [t.strip() for t in themes.split(',')]
            elif isinstance(themes, list):
                theme_list = themes
            else:
                theme_list = []

            js_playlists[playlist_name][error_code] = theme_list

    print("window.FAIRER_PLAYLISTS = " + json.dumps(js_playlists, indent=2) + ";")

except Exception as e:
    sys.stderr.write("ERROR parsing YAML: " + str(e) + "\n")
    sys.exit(1)
PYTHON_SCRIPT
fi

# Check if CSV mode is requested
if [ -n "$FAIRER_PLAYLIST_CSV" ]; then
    echo "Using CSV playlist: $FAIRER_PLAYLIST_CSV"

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
    with open(sys.argv[1], 'r') as f:
        config = yaml.safe_load(f)

    playlists = config.get('playlists', {})
    js_playlists = {}

    for playlist_name, playlist_data in playlists.items():
        js_playlists[playlist_name] = {}
        for error_code, themes in playlist_data.items():
            if isinstance(themes, str):
                theme_list = [t.strip() for t in themes.split(',')]
            elif isinstance(themes, list):
                theme_list = themes
            else:
                theme_list = []
            js_playlists[playlist_name][error_code] = theme_list

    print("window.FAIRER_PLAYLISTS = " + json.dumps(js_playlists, indent=2) + ";")

except Exception as e:
    sys.stderr.write("ERROR parsing YAML: " + str(e) + "\n")
    sys.exit(1)
PYTHON_SCRIPT
fi

echo "Playlist configuration generated at $OUTPUT_JS"

# Start nginx
echo "Starting nginx on port $LISTEN_PORT..."
exec nginx -c /tmp/nginx.conf -g "daemon off;"
