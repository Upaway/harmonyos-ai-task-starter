#!/usr/bin/env python3
"""Generate 1024x1024 layered PNGs for HarmonyOS app icon (foreground + background)."""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw

SIZE = 1024
# Design originally in 512 space; scale to 1024 => factor 2
K = 2.0

RGB_BG_TOP = (0x18, 0x20, 0x26)
RGB_BG_BOT = (0x30, 0x42, 0x52)
COL_SUN = (0xE7, 0xB9, 0x7A)
COL_FACE = (0xF6, 0xF0, 0xE8)


def _lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def _lerp_rgb(
    c1: tuple[int, int, int], c2: tuple[int, int, int], t: float
) -> tuple[int, int, int]:
    return (
        int(round(_lerp(c1[0], c2[0], t))),
        int(round(_lerp(c1[1], c2[1], t))),
        int(round(_lerp(c1[2], c2[2], t))),
    )


def cubic_bezier(
    p0: tuple[float, float],
    p1: tuple[float, float],
    p2: tuple[float, float],
    p3: tuple[float, float],
    steps: int,
) -> list[tuple[float, float]]:
    pts = []
    for i in range(steps + 1):
        t = i / steps
        u = 1.0 - t
        x = (
            u**3 * p0[0]
            + 3 * u**2 * t * p1[0]
            + 3 * u * t**2 * p2[0]
            + t**3 * p3[0]
        )
        y = (
            u**3 * p0[1]
            + 3 * u**2 * t * p1[1]
            + 3 * u * t**2 * p2[1]
            + t**3 * p3[1]
        )
        pts.append((x, y))
    return pts


def make_background(out: Path) -> None:
    img = Image.new("RGB", (SIZE, SIZE))
    px = img.load()
    denom = 2.0 * (SIZE - 1)
    for y in range(SIZE):
        for x in range(SIZE):
            t = (x + y) / denom
            px[x, y] = _lerp_rgb(RGB_BG_TOP, RGB_BG_BOT, t)
    img.save(out, "PNG")


def make_foreground(out: Path) -> None:
    img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Circle (sun): SVG cx=180 cy=176 r=36 in 512 space
    cx, cy, r = 180 * K, 176 * K, 36 * K
    bbox = (cx - r, cy - r, cx + r, cy + r)
    draw.ellipse(bbox, fill=COL_SUN)

    # Path 1: smile arc — M146 320 c24,-46 58,-72 110,-72 c44,0 83,19 110,56
    x0, y0 = 146 * K, 320 * K
    # first cubic relative to (x0,y0)
    p0 = (x0, y0)
    p1 = (x0 + 24 * K, y0 - 46 * K)
    p2 = (x0 + 58 * K, y0 - 72 * K)
    p3 = (x0 + 110 * K, y0 - 72 * K)
    seg1 = cubic_bezier(p0, p1, p2, p3, 48)
    p4 = p3
    p5 = (p3[0] + 44 * K, p3[1] + 0 * K)
    p6 = (p3[0] + 83 * K, p3[1] + 19 * K)
    p7 = (p3[0] + 110 * K, p3[1] + 56 * K)
    seg2 = cubic_bezier(p4, p5, p6, p7, 48)
    stroke_w = int(round(34 * K))
    for seg in (seg1, seg2):
        for i in range(len(seg) - 1):
            draw.line([seg[i], seg[i + 1]], fill=COL_FACE, width=stroke_w)

    # Path 2: check — M336 168 l36 0 0 108  (polyline right then down)
    x1, y1 = 336 * K, 168 * K
    x2, y2 = x1 + 36 * K, y1
    x3, y3 = x2, y2 + 108 * K
    stroke2 = int(round(28 * K))
    draw.line([(x1, y1), (x2, y2)], fill=COL_SUN, width=stroke2)
    draw.line([(x2, y2), (x3, y3)], fill=COL_SUN, width=stroke2)

    img.save(out, "PNG")


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    media = root / "AppScope" / "resources" / "base" / "media"
    media.mkdir(parents=True, exist_ok=True)
    make_background(media / "app_icon_background.png")
    make_foreground(media / "app_icon_foreground.png")
    print("Wrote:", media / "app_icon_background.png")
    print("Wrote:", media / "app_icon_foreground.png")


if __name__ == "__main__":
    main()
