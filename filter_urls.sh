#!/bin/bash

# Function to display help
function usage() {
    echo "Usage: $0 [-i input_file] [-o output_file] [-w whitelist] [-b blacklist] [-f filters]"
    echo
    echo "Options:"
    echo "  -i, --input       Input file containing URLs"
    echo "  -o, --output      Output file to save filtered URLs (optional)"
    echo "  -w, --whitelist   Whitelist specific extensions (comma-separated, e.g., php,html,asp)"
    echo "  -b, --blacklist   Blacklist specific extensions (comma-separated, e.g., jpg,png,css)"
    echo "  -f, --filters     Apply filters (comma-separated, e.g., hasparams,noparams,hasext,noext)"
    echo "                    Available filters:"
    echo "                    hasparams  - URLs with query parameters"
    echo "                    noparams   - URLs without query parameters"
    echo "                    hasext     - URLs with extensions"
    echo "                    noext      - URLs without extensions"
    echo "                    keepcontent - Keep blog-like content"
    echo "                    keepslash   - Retain trailing slashes in URLs"
    exit 1
}

# Parse arguments
INPUT_FILE=""
OUTPUT_FILE=""
WHITELIST=""
BLACKLIST=""
FILTERS=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--input) INPUT_FILE="$2"; shift ;;
        -o|--output) OUTPUT_FILE="$2"; shift ;;
        -w|--whitelist) WHITELIST="$2"; shift ;;
        -b|--blacklist) BLACKLIST="$2"; shift ;;
        -f|--filters) FILTERS="$2"; shift ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
    shift
done

# Validate input file
if [[ -z "$INPUT_FILE" || ! -f "$INPUT_FILE" ]]; then
    echo "Error: Input file not specified or doesn't exist."
    usage
fi

# Read the input file
URLS=$(cat "$INPUT_FILE")

# Apply filters
if [[ -n "$WHITELIST" ]]; then
    IFS=',' read -r -a whitelist <<< "$WHITELIST"
    URLS=$(echo "$URLS" | grep -E "\.(${whitelist[*]// /|})$")
fi

if [[ -n "$BLACKLIST" ]]; then
    IFS=',' read -r -a blacklist <<< "$BLACKLIST"
    URLS=$(echo "$URLS" | grep -Ev "\.(${blacklist[*]// /|})$")
fi

if [[ "$FILTERS" == *"hasparams"* ]]; then
    URLS=$(echo "$URLS" | grep '\?')
fi

if [[ "$FILTERS" == *"noparams"* ]]; then
    URLS=$(echo "$URLS" | grep -v '\?')
fi

if [[ "$FILTERS" == *"hasext"* ]]; then
    URLS=$(echo "$URLS" | grep '\.[a-zA-Z0-9]\+$')
fi

if [[ "$FILTERS" == *"noext"* ]]; then
    URLS=$(echo "$URLS" | grep -v '\.[a-zA-Z0-9]\+$')
fi

if [[ "$FILTERS" == *"keepcontent"* ]]; then
    URLS=$(echo "$URLS" | grep -E '/blog|/posts|/articles|/news')
fi

if [[ "$FILTERS" == *"keepslash"* ]]; then
    URLS=$(echo "$URLS" | sed -e 's|[^/]$|&/|')
fi

# Output the results
if [[ -n "$OUTPUT_FILE" ]]; then
    echo "$URLS" > "$OUTPUT_FILE"
    echo "Filtered URLs saved to $OUTPUT_FILE"
else
    echo "$URLS"
fi
