#!/bin/bash
# Simple local web server for testing the app

PORT="${1:-8000}"

echo "=========================================="
echo "Starting local web server..."
echo "=========================================="
echo ""
echo "Open in your browser:"
echo "  http://localhost:$PORT"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Try Python 3 first, then Python 2
if command -v python3 &> /dev/null; then
    python3 -m http.server $PORT
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer $PORT
else
    echo "ERROR: Python not found. Please install Python to run a local server."
    echo ""
    echo "Alternative: Use any other local web server like:"
    echo "  - npx serve"
    echo "  - php -S localhost:$PORT"
    exit 1
fi
