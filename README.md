# depth-anythingv2-test1

Depth Anything V2의 **근경 물체 효과**를 보여주는 결과 페이지 (GitHub Pages / Jekyll).

**1부** — 모델 크기 비교가 아니다. **V2-Large · fp32 하나로만** 돌리고, 바꾼 것은 입력 화면의 구성뿐이다.
화면에서 가장 가까운 물체가 상대 역깊이의 값 범위를 독점해 그 뒤를 전부 누른다는 것을 보인다.
영상 1 아래에는 **같은 촬영본의 DAv3 결과**를 참고로 붙였다 (우리 파이프라인 산출물이 아니라
예전에 받아둔 것이며, 조건이 통제돼 있지 않다는 단서를 페이지에 함께 적었다).

**2부** — 폰 카메라 실시간 스트리밍에서 S/B/L을 각 15초씩 fp32로 비교한다.
장면과 조건을 고정하고 모델 크기만 바꾼다.

## 구조

| 경로 | 용도 |
|---|---|
| `index.md` | 페이지 본문 |
| `assets/video/` | 웹 재생용 H.264 변환본 |
| `raw/` | 측정 원본 CSV |
| `encode.sh` | 원본 mp4 → 웹용 H.264 변환 |

## 영상 갱신

원본은 `depth-anything-feasibility/outputs/test1/` 아래(3분할 비교는 `crop_compare/`,
DAv3 참고 영상은 `drone04.mp4`)에 있고 코덱이 mpeg4라 브라우저에서 재생되지 않는다.
`./encode.sh`가 H.264 + `faststart`로 변환한다.

## 원본 생성

```bash
cd ~/Desktop/Jihyuck/depth-anything-feasibility
python src/compare_crop.py --video outputs/test1/IMG_E5065.MOV \
    --model large --dtype fp32 --cut-top 0.25 --keep-top 0.50 --out-dir outputs/test1/crop_compare
python src/compare_crop.py --video outputs/test1/JPKYE9578.MOV \
    --model large --dtype fp32 --keep-top 0.45 --out-dir outputs/test1/crop_compare

# 페이지의 contrast 표
python src/measure_drone_contrast.py --video outputs/test1/IMG_E5065.MOV \
    --cut-top 0.25 --keep-top 0.50
```
