#!/usr/bin/env bash
# 원본(mpeg4)을 웹 자동재생용 H.264 MP4로 변환한다.
set -euo pipefail
BASE=/home/aims/Desktop/Jihyuck/depth-anything-feasibility/outputs/test1
DST=/home/aims/Desktop/Jihyuck/depth-anythingv2-test1/assets/video

echo "== 1부: 근경 제거 3분할 비교 =="
for v in 20260413_174025 JPKYE9578; do
  ffmpeg -v error -y -i "$BASE/crop_compare/${v}_large_fp32_cropcmp.mp4" \
    -c:v libx264 -preset veryfast -crf 27 -an -pix_fmt yuv420p \
    -vf "scale=1200:-2" -r 20 -movflags +faststart "$DST/${v}.mp4"
  printf '  %-28s %6s KB\n' "${v}.mp4" "$(( $(stat -c%s "$DST/${v}.mp4") / 1024 ))"
done

echo "== 2부: 실내 실시간 S/B/L =="
# 재생 시간 = 실제 소요 시간이 되도록 fps를 바꾸지 않는다 (-r 없음)
mkdir -p "$DST/indoor"
for m in small base large; do
  ffmpeg -v error -y -i "$BASE/indoor/indoor_fp32_${m}.mp4" \
    -c:v libx264 -preset veryfast -crf 26 -an -pix_fmt yuv420p \
    -vf "scale=1200:-2" -movflags +faststart "$DST/indoor/${m}.mp4"
  printf '  %-28s %6s KB\n' "indoor/${m}.mp4" "$(( $(stat -c%s "$DST/indoor/${m}.mp4") / 1024 ))"
done
