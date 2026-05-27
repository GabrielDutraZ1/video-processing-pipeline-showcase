#!/bin/bash

# =========================================

# VIDEO PROCESSING PIPELINE - SHOWCASE

# =========================================

RAW_DIR="/mnt/videos/@GRAD"
OUTPUT_DIR="/mnt/videos/@CONVERTED_GRAD"

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/showcase_pipeline.log"

mkdir -p "$LOG_DIR"

echo "======================================="
echo " VIDEO PROCESSING PIPELINE STARTED "
echo "======================================="

while true
do

```
echo "[$(date '+%H:%M:%S')] Starting scan..."

VIDEO_LIST=$(find "$RAW_DIR" -type f -name "*.mp4" | sort)

while IFS= read -r VIDEO
do

    NAME=$(basename "$VIDEO")
    DIRECTORY=$(dirname "$VIDEO")

    BASE="${NAME%.mp4}"

    # Ignore already converted outputs
    if [[ "$BASE" == *_1080p ]] || \
       [[ "$BASE" == *_720p ]] || \
       [[ "$BASE" == *_480p ]]; then
        continue
    fi

    RELATIVE="${DIRECTORY#$RAW_DIR/}"

    DESTINATION="$OUTPUT_DIR/$RELATIVE"

    mkdir -p "$DESTINATION"

    OUTPUT_1080="$DESTINATION/${BASE}_1080p.mp4"
    OUTPUT_720="$DESTINATION/${BASE}_720p.mp4"
    OUTPUT_480="$DESTINATION/${BASE}_480p.mp4"

    echo "[$(date '+%H:%M:%S')] Processing: $NAME"

    # =========================================
    # 1080P
    # =========================================

    ffmpeg -i "$VIDEO" \
    -vf "scale=-2:1080" \
    -vcodec libx264 \
    -crf 24 \
    "$OUTPUT_1080" -y

    sleep 5

    # =========================================
    # 720P
    # =========================================

    ffmpeg -i "$VIDEO" \
    -vf "scale=-2:720" \
    -vcodec libx264 \
    -crf 24 \
    "$OUTPUT_720" -y

    sleep 5

    # =========================================
    # 480P
    # =========================================

    ffmpeg -i "$VIDEO" \
    -vf "scale=-2:480" \
    -vcodec libx264 \
    -crf 24 \
    "$OUTPUT_480" -y

    echo "[$(date '+%H:%M:%S')] Completed: $NAME"

done <<< "$VIDEO_LIST"

echo "[$(date '+%H:%M:%S')] Scan complete"

sleep 300
```

done
