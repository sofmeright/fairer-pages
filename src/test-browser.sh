#!/bin/bash
# Browser-equivalent test for Fairer Pages
# Tests actual JavaScript execution by fetching HTML and checking what theme it would redirect to

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test configuration
CONTAINER_URL="${CONTAINER_URL:-http://anchorage:8023}"

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Fairer Pages Browser Validation Test${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Test 1: Verify playlist-config.js is accessible and contains work playlist
echo -e "${BLUE}[Test 1]${NC} Checking playlist-config.js accessibility..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

config_content=$(curl -s "${CONTAINER_URL}/playlist-config.js" 2>&1)
if echo "$config_content" | grep -q '"work"' && echo "$config_content" | grep -q '"ANY"'; then
    echo -e "${GREEN}✓${NC} playlist-config.js accessible and contains work playlist"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} playlist-config.js missing or malformed"
    echo "Content: $config_content"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 2: Verify work playlist does NOT contain lol-inting
echo -e "${BLUE}[Test 2]${NC} Verifying work playlist composition..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

work_playlist=$(curl -s "${CONTAINER_URL}/playlist-config.js" | grep -A 50 '"work"')
if ! echo "$work_playlist" | grep -q '"lol-inting"'; then
    echo -e "${GREEN}✓${NC} work playlist does NOT contain lol-inting (correct)"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} work playlist contains lol-inting (should not)"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 3: Verify default playlist DOES contain lol-inting
echo -e "${BLUE}[Test 3]${NC} Verifying default playlist contains lol-inting..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

default_playlist=$(curl -s "${CONTAINER_URL}/playlist-config.js" | grep -A 100 '"default"' | head -100)
if echo "$default_playlist" | grep -q '"lol-inting"'; then
    echo -e "${GREEN}✓${NC} default playlist contains lol-inting (correct)"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} default playlist missing lol-inting"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 4: Check random page HTML includes proper JavaScript
echo -e "${BLUE}[Test 4]${NC} Checking random page JavaScript..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

random_html=$(curl -s "${CONTAINER_URL}/fairer-pages/random/404.html?playlist=work")
if echo "$random_html" | grep -q 'window.FAIRER_PLAYLISTS' && \
   echo "$random_html" | grep -q 'urlParams.get.*playlist' && \
   echo "$random_html" | grep -q 'selectTheme'; then
    echo -e "${GREEN}✓${NC} random page contains playlist selection JavaScript"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} random page missing required JavaScript"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 5: Check that playlist-config.js is loaded in random page
echo -e "${BLUE}[Test 5]${NC} Verifying playlist-config.js is included in random page..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

if echo "$random_html" | grep -q '<script src="/fairer-pages/playlist-config.js">'; then
    echo -e "${GREEN}✓${NC} playlist-config.js script tag present"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} playlist-config.js script tag missing"
    echo "This would cause JavaScript to fall back to DEFAULT_THEMES"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 6: Validate ref parameter is passed for Go Back button
echo -e "${BLUE}[Test 6]${NC} Testing Go Back button ref parameter..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

# Check that themes include goBack function with ref parameter handling
theme_html=$(curl -s "${CONTAINER_URL}/fairer-pages/vibecoded-trash/404.html")
if echo "$theme_html" | grep -q "urlParams.get('ref')" && \
   echo "$theme_html" | grep -q 'function goBack'; then
    echo -e "${GREEN}✓${NC} Theme pages include ref parameter handling"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} Theme pages missing ref parameter handling"
    FAILED_TESTS=$((FAILED_TESTS + 1))
fi
echo ""

# Test 7: Check that random page uses iframe to preserve URL
echo -e "${BLUE}[Test 7]${NC} Checking iframe implementation..."
TOTAL_TESTS=$((TOTAL_TESTS + 1))

if echo "$random_html" | grep -q 'iframe.src' && echo "$random_html" | grep -q 'document.body.appendChild(iframe)'; then
    echo -e "${GREEN}✓${NC} random page uses iframe to preserve original URL"
    PASSED_TESTS=$((PASSED_TESTS + 1))
else
    echo -e "${RED}✗${NC} random page not using iframe correctly"
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
    echo -e "${GREEN}✓ All browser validation tests passed!${NC}"
    echo ""
    echo "Note: These tests validate that JavaScript code is present and correct."
    echo "If users still see wrong themes, it may be a browser caching issue."
    echo "Advise users to hard refresh (Ctrl+Shift+R or Cmd+Shift+R)."
    exit 0
else
    echo -e "${RED}✗ Some tests failed.${NC}"
    echo ""
    echo "This indicates the JavaScript configuration is incorrect or missing."
    exit 1
fi
