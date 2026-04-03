#!/bin/bash
# it needs template on /home/gabriel
# 1. Define the timestamp and paths
TIMESTAMP=$(date +%Y-%m-%d_%H-%M)
REPORT_DIR="/home/gabriel/Documents/reports/$(date +%Y-%m)"
REPORT_FILE="${REPORT_DIR}/trivy_report_${TIMESTAMP}.html"

# 2. Ensure the directory exists
mkdir -p "$REPORT_DIR"

# 3. Run the scan
# We use the absolute path to your modern template
sudo trivy fs \
  --format template \
  --template "@/home/gabriel/modern.tpl" \
  --output "$REPORT_FILE" \
  --skip-dirs "/home/gabriel/.local/share/flatpak" \
  --skip-dirs "/home/gabriel/.local/share/ollama" \
  --timeout 20m \
  /

# 4. (Optional) Create a symlink to the absolute latest for easy access
ln -sf "$REPORT_FILE" "/home/gabriel/Documents/reports/latest_results.html"

echo "Scan complete. Report saved to: $REPORT_FILE"
