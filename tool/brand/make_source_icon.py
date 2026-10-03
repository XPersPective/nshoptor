#!/usr/bin/env python3
"""NShoptor kaynak ikonunu (1024px) programatik üretir.

Tasarım: marka yeşili (#0B8457) daire + beyaz alışveriş sepeti motifi.
Nihai marka görseli Crazy Penguin onayına bağlı (PB-041 Decision
Boundary); bu, tek kaynaktan tüm platform ikonlarını üreten geliştirme
ikonudur.

Kullanım:
  python tool/brand/make_source_icon.py --out assets/brand/icon_1024.png
"""
from __future__ import annotations

import argparse
from pathlib import Path

from PIL import Image, ImageDraw

BRAND = (0x0B, 0x84, 0x57, 255)  # 0xFF0B8457 (marka kısıtı)
WHITE = (255, 255, 255, 255)


def make_icon(size: int) -> Image.Image:
    s = size / 1024.0
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)

    # Marka yeşili daire: köşeler şeffaf (monochrome silüeti için gerekli).
    m = round(size * 0.02)
    d.ellipse([m, m, size - 1 - m, size - 1 - m], fill=BRAND)

    # Sepet gövdesi: yarı saydam dolgu önce (üstüne kontur gelir).
    top_y, bot_y = round(500 * s), round(790 * s)
    top_l, top_r = round(250 * s), round(774 * s)
    bot_l, bot_r = round(330 * s), round(694 * s)
    d.polygon(
        [(top_l, top_y), (top_r, top_y), (bot_r, bot_y), (bot_l, bot_y)],
        fill=(255, 255, 255, 36),
    )

    lw = max(4, round(52 * s))
    # Kulp: yay.
    d.arc(
        [round(320 * s), round(190 * s), round(704 * s), round(560 * s)],
        start=180, end=360, fill=WHITE, width=lw,
    )
    # Gövde konturu + ağız çizgisi.
    d.polygon(
        [(top_l, top_y), (top_r, top_y), (bot_r, bot_y), (bot_l, bot_y)],
        outline=WHITE, width=lw,
    )
    d.line([(top_l, top_y), (top_r, top_y)], fill=WHITE, width=lw)
    # Dişler.
    tw = max(3, round(30 * s))
    for x in (round(430 * s), round(596 * s)):
        d.line([(x, round(540 * s)), (x - round(24 * s), round(750 * s))],
               fill=WHITE, width=tw)
    return img


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--out", type=Path,
                    default=Path("assets/brand/icon_1024.png"))
    ap.add_argument("--size", type=int, default=1024)
    args = ap.parse_args()
    args.out.parent.mkdir(parents=True, exist_ok=True)
    make_icon(args.size).save(args.out, "PNG")
    print(f"kaynak ikon: {args.out} ({args.size}x{args.size})")


if __name__ == "__main__":
    main()
