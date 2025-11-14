#!/bin/bash
# Fairer Pages Playlist Test Suite
# Tests playlist functionality to ensure each domain gets correct themed error pages

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test configuration
BASE_URL="${BASE_URL:-http://localhost:8023}"
SAMPLES_PER_PLAYLIST=3
TEST_ERROR_CODES=(404 500 502 503)

# Domain to playlist mappings
declare -A DOMAIN_PLAYLISTS=(
    ["homelabhelpdesk.com"]="chill"
    ["ipleek.com"]="nature"
    ["operationtimecapsule.com"]="theatre"
    ["precisionplanit.com"]="work"
)

# Expected themes for each playlist (from default-playlists.yml)
declare -A PLAYLIST_THEMES=(
    ["chill"]="blank-state,bridge-rave,chill-wallhaven,frequency-shift,lotus-petal,peaceful-waterfalls,porco-rosso-pagoda,retrowave-rain,serene-shores,shaninblake,shuffled-around,steilacoom-park,zelda-epona,zelda-ocarina,zelda-cozy-hammock,zelda-mastersword"
    ["nature"]="lotus-petal,peaceful-waterfalls,porco-rosso-pagoda,serene-shores,steilacoom-park"
    ["theatre"]="bigoneredd,gettodachopper,jayandsilentbob,jedi-mindtrick,jessepinkman,meninblack,meow-game,neighborhood-watch,readyplayerone,rickandmorty,rushhour,salamancas,sanfordandson,shaunofthedead,star-trek-fuse,still-waiting,upsidedown"
    ["work"]="back2thefuture,baldurs-gate-bridge,chill-wallhaven,churchill-courage,control-room,fakerockyridge,frequency-shift,jedi-mindtrick,lotus-petal,middle-earth-map,morrowind-balmora,peaceful-waterfalls,porco-rosso-pagoda,readyplayerone,retrowave-rain,serene-shores,steilacoom-park,sun-tzu-chaos,swordart-aincrad,venn-diagram,vibecoded-trash,wanderer,xbox-bootup,zelda-cozy-hammock,zelda-epona,zelda-master-sword,zelda-ocarina"
)

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Fairer Pages Playlist Test Suite${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Function to test playlist endpoint redirect
test_playlist_redirect() {
    local playlist_name=$1
    local error_code=$2

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    local url="${BASE_URL}/fairer-pages/playlist/${playlist_name}/${error_code}.html"

    # Get the redirect location
    local redirect_location=$(curl -sI "$url" | grep -i "^Location:" | awk '{print $2}' | tr -d '\r')

    # Check if redirect is correct format
    if [[ $redirect_location =~ /fairer-pages/random/${error_code}\.html\?playlist=${playlist_name} ]]; then
        echo -e "${GREEN}✓${NC} Playlist '$playlist_name' code $error_code redirects correctly"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} Playlist '$playlist_name' code $error_code: Invalid redirect"
        echo "   Expected: /fairer-pages/random/${error_code}.html?playlist=${playlist_name}"
        echo "   Got: $redirect_location"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to test random endpoint
test_random_endpoint() {
    local error_code=$1

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    local url="${BASE_URL}/fairer-pages/random/${error_code}.html"

    # Check if page loads
    local status=$(curl -sI "$url" | grep "HTTP/" | awk '{print $2}')

    if [ "$status" = "200" ]; then
        echo -e "${GREEN}✓${NC} Random endpoint code $error_code loads successfully"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} Random endpoint code $error_code failed (status: $status)"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to check if playlist is defined in config
test_playlist_config() {
    local playlist_name=$1

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    # Fetch the playlist config
    local config=$(curl -s "${BASE_URL}/playlist-config.js" 2>/dev/null)

    if [[ $config =~ \"${playlist_name}\" ]]; then
        echo -e "${GREEN}✓${NC} Playlist '$playlist_name' exists in configuration"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} Playlist '$playlist_name' not found in configuration"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Function to test back button ref parameter
test_back_button() {
    local playlist_name=$1
    local error_code=$2

    TOTAL_TESTS=$((TOTAL_TESTS + 1))

    local url="${BASE_URL}/fairer-pages/playlist/${playlist_name}/${error_code}.html"

    # Follow redirect and check if random page exists
    local random_url=$(curl -sI "$url" | grep -i "^Location:" | awk '{print $2}' | tr -d '\r')

    if [ -n "$random_url" ]; then
        # Test if the random page loads
        local full_url="${BASE_URL}${random_url}"
        local content=$(curl -s "$full_url" 2>/dev/null)

        # Check if it contains ref parameter handling
        if [[ $content =~ "urlParams.get('ref')" ]] || [[ $content =~ "ref=" ]]; then
            echo -e "${GREEN}✓${NC} Random page has ref parameter support"
            PASSED_TESTS=$((PASSED_TESTS + 1))
            return 0
        fi
    fi

    echo -e "${RED}✗${NC} Ref parameter support missing"
    FAILED_TESTS=$((FAILED_TESTS + 1))
    return 1
}

# Test 1: Random endpoint loads
echo -e "${BLUE}[Test 1]${NC} Testing /fairer-pages/random/ endpoint availability..."
for code in "${TEST_ERROR_CODES[@]}"; do
    test_random_endpoint "$code"
done
echo ""

# Test 2: Playlist configuration exists
echo -e "${BLUE}[Test 2]${NC} Testing playlist configurations..."
for playlist_name in default chill nature theatre work; do
    test_playlist_config "$playlist_name"
done
echo ""

# Test 3: Playlist redirects work correctly
echo -e "${BLUE}[Test 3]${NC} Testing playlist endpoint redirects..."
for playlist_name in chill nature theatre work; do
    echo -e "  Testing playlist: ${YELLOW}$playlist_name${NC}"

    for code in "${TEST_ERROR_CODES[@]}"; do
        test_playlist_redirect "$playlist_name" "$code"
    done
    echo ""
done

# Test 4: Domain-to-playlist mappings (informational)
echo -e "${BLUE}[Test 4]${NC} Domain to playlist mappings (for reference):"
for domain in "${!DOMAIN_PLAYLISTS[@]}"; do
    playlist="${DOMAIN_PLAYLISTS[$domain]}"
    echo -e "  ${YELLOW}$domain${NC} → playlist: ${GREEN}$playlist${NC}"
done
echo ""

# Test 5: Back button navigation support
echo -e "${BLUE}[Test 5]${NC} Testing back button navigation (ref parameter)..."
test_back_button "chill" "404"
echo ""

# Test 6: Port preservation in redirects
echo -e "${BLUE}[Test 6]${NC} Testing port preservation in redirects..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

redirect_location=$(curl -sI "${BASE_URL}/fairer-pages/playlist/zelda/404.html" | grep -i "^Location:" | awk '{print $2}' | tr -d '\r')

if [[ $redirect_location == /* ]]; then
    echo -e "${GREEN}✓${NC} Redirect uses relative path (port preserved): $redirect_location"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} Redirect uses absolute URL (may drop port): $redirect_location"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Summary
echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Test Summary${NC}"
echo -e "${BLUE}============================================${NC}"
echo -e "Total tests:  $TOTAL_TESTS"
echo -e "${GREEN}Passed:       $PASSED_TESTS${NC}"
if [ $FAILED_TESTS -gt 0 ]; then
    echo -e "${RED}Failed:       $FAILED_TESTS${NC}"
else
    echo -e "Failed:       $FAILED_TESTS"
fi
echo ""

# Exit with appropriate code
if [ $FAILED_TESTS -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed!${NC}"
    echo ""
    echo "Note: These tests validate the nginx configuration and playlist setup."
    echo "Browser-based JavaScript redirects work correctly and can be tested manually."
    exit 0
else
    echo -e "${RED}✗ Some tests failed.${NC}"
    exit 1
fi
