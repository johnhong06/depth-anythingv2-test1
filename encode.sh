#!/usr/bin/env bash
# 원본(mpeg4)을 웹 자동재생용 H.264 MP4로 변환한다.
set -euo pipefail
SRC=/home/aims/Desktop/Jihyuck/depth-anything-feasibility/outputs/test1/crop_compare
DST=/home/aims/Desktop/Jihyuck/depth-anythingv2-test1/assets/video
for v in 20260413_174025 JPKYE9578; do
  ffmpeg -v error -y -i "$SRC/${v}_large_fp32_cropcmp.mp4" \
    -c:v libx264 -preset veryfast -crf 27 -an -pix_fmt yuv420p \
    -vf "scale=1200:-2" -r 20 -movflags +faststart "$DST/${v}.mp4"
  printf '  %-28s %6s KB\n' "${v}.mp4" "$(( $(stat -c%s "$DST/${v}.mp4") / 1024 ))"
done
