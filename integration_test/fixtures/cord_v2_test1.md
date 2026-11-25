# CORDv2 test-row-1 provenance

- Dataset: [CORDv2](https://huggingface.co/datasets/naver-clova-ix/cord-v2), NAVER CLOVA, CC BY 4.0.
- Pinned dataset revision: `7f0115a4b758a71d6473b8d085751692da2fef98`.
- Row: `test`, zero-based offset `1` (`image_id: 1`), dimensions `960 × 1280`.
- Public image SHA-256: `636284664cfc357e05f7b10d67ddb380f828a1be0a20809514f9e7fc0c611a9f` (56,652 bytes).
- Annotated menu values: `17,500`, `46,000`, `27,500`; annotated total: `91,000` (Indonesian rupiah).
- CORDv2 masks/redacts identifying header information. The fixture deliberately keeps that header incomplete; the test must reject finalization and leave all three persistence tables empty.

`tool/qa/prepare_cord_fixture.py` reads the pinned row from the official Hugging Face datasets-server endpoint, validates its ground truth, downloads the image only from the allowlisted HTTPS dataset host, checks the pinned JPEG hash, and writes a temporary `--dart-define-from-file` JSON outside the repository. The image and base64 payload are not committed.

This is one public photographed receipt and a regression fixture for these annotated amounts. It does not establish OCR accuracy for other layouts, scripts, currencies, physical-camera captures, or complete receipts. The independent synthetic receipt fixture continues to cover a complete-header approval path.
