#!/bin/bash
# Fairer Pages Domain Test Suite
# Tests actual production domains to validate playlist functionality

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test configuration
CONTAINER_URL="${CONTAINER_URL:-http://anchorage:8023}"
TEST_ERROR_CODES=(404 500 502 503)

# Production domains with their expected playlists
declare -A DOMAIN_PLAYLISTS=(
    ["https://homelabhelpdesk.com"]="chill"
    ["https://ipleek.com"]="nature"
    ["https://operationtimecapsule.com"]="theatre"
    ["https://precisionplanit.com"]="work"
)

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Fairer Pages Domain Test Suite${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Test container endpoint first
echo -e "${BLUE}[Test 1]${NC} Testing container endpoints via ${YELLOW}${CONTAINER_URL}${NC}..."

test_container_playlist() {
    local playlist=$1
    local code=$2
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    local url="${CONTAINER_URL}/fairer-pages/playlist/${playlist}/${code}.html"
    local redirect=$(curl -sI "$url" 2>&1 | grep -i "^Location:" | awk '{print $2}' | tr -d '\r')
    
    if [[ $redirect =~ /fairer-pages/random/${code}\.html\?playlist=${playlist} ]]; then
        echo -e "${GREEN}✓${NC} Container: playlist '${playlist}' code ${code} redirects correctly"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} Container: playlist '${playlist}' code ${code} failed"
        echo "   Expected: /fairer-pages/random/${code}.html?playlist=${playlist}"
        echo "   Got: $redirect"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Test each playlist on container
for playlist in chill nature theatre work; do
    test_container_playlist "$playlist" "404"
done
echo ""

# Test production domains
echo -e "${BLUE}[Test 2]${NC} Testing production domains..."

test_domain() {
    local domain=$1
    local expected_playlist=$2
    local test_path="/nonexistent-test-page-$(date +%s)"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    echo -e "  Testing ${YELLOW}${domain}${NC} (expects playlist: ${expected_playlist})..."
    
    # Make request to non-existent page
    local response=$(curl -sIL "${domain}${test_path}" 2>&1)
    
    # Check if it redirects through the playlist system
    if echo "$response" | grep -q "location.*random.*playlist=${expected_playlist}"; then
        echo -e "${GREEN}✓${NC} ${domain} routes to playlist '${expected_playlist}'"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        # Check what it actually shows
        local actual_redirect=$(echo "$response" | grep -i "location:" | tail -1 | awk '{print $2}' | tr -d '\r')
        echo -e "${RED}✗${NC} ${domain} routing failed"
        echo "   Expected: playlist=${expected_playlist}"
        echo "   Got: $actual_redirect"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

for domain in "${!DOMAIN_PLAYLISTS[@]}"; do
    playlist="${DOMAIN_PLAYLISTS[$domain]}"
    test_domain "$domain" "$playlist"
done
echo ""

# Test random endpoint on container
echo -e "${BLUE}[Test 3]${NC} Testing random endpoint loads..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

random_status=$(curl -sI "${CONTAINER_URL}/fairer-pages/random/404.html" 2>&1 | grep "HTTP/" | awk '{print $2}')

if [ "$random_status" = "200" ]; then
    echo -e "${GREEN}✓${NC} Random endpoint loads successfully"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} Random endpoint failed (status: $random_status)"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test playlist-config.js availability
echo -e "${BLUE}[Test 4]${NC} Testing playlist configuration file..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

config_status=$(curl -sI "${CONTAINER_URL}/playlist-config.js" 2>&1 | grep "HTTP/" | awk '{print $2}')

if [ "$config_status" = "200" ]; then
    echo -e "${GREEN}✓${NC} Playlist config file accessible"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} Playlist config file not accessible (status: $config_status)"
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
    exit 0
else
    echo -e "${RED}✗ Some tests failed.${NC}"
    echo ""
    echo "Note: If domain tests fail but container tests pass,"
    echo "check your reverse proxy configuration on each domain."
    exit 1
fi
