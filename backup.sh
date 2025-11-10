#!/bin/bash

# ======= CONFIGURATION =======
SOURCE_DIR="/c/Users/harip/Documents/myproject"
BACKUP_DIR="/c/Users/harip/Desktop/backups"
LOG_FILE="$BACKUP_DIR/backup.log"  # Log file path
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
# =============================

# Create backup directory if not exists
mkdir -p "$BACKUP_DIR"

# Create backup
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# Log the backup action
echo "[$(date)] Backup created: $BACKUP_NAME" >> "$LOG_FILE"

echo "✅ Backup Successful!"
echo "File saved as: $BACKUP_DIR/$BACKUP_NAME"
