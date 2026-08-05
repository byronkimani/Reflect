#!/usr/bin/env python3
"""Generate Reflect splash and app icon PNGs.

Outputs:
  assets/icons/app_icon.png           — mark only (launcher)
  assets/icons/splash_fullscreen.png  — full-screen mark + Reflect lockup
  assets/icons/splash_ios_native.png  — iOS native launch (mark only, same position)
"""

from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

PAPER = (0xF5, 0xF3, 0xEE)
INK = (0x0D, 0x0D, 0x0D)

ROOT = Path(__file__).resolve().parent.parent
ICONS = ROOT / "assets" / "icons"

# iPhone 14 Pro Max logical @3x canvas used by flutter_native_splash.
SPLASH_W = 1284
SPLASH_H = 2778
ICON_SIZE = 1024

MARK_SCALE = 1.0
FONT_SIZE = 112
LINE_TO_TEXT_GAP = 70


@dataclass(frozen=True)
class LockupLayout:
    mark_cy: int
    mark_scale: float
    lockup_top: int
    mark_height: int
    text_x: int
    text_y: int
    word: str


def _load_bold_font(size: int) -> ImageFont.FreeTypeFont | ImageFont.ImageFont:
    candidates = [
        "/System/Library/Fonts/Supplemental/Arial Bold.ttf",
        "/Library/Fonts/Arial Bold.ttf",
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
    ]
    for path in candidates:
        if os.path.exists(path):
            return ImageFont.truetype(path, size)
    return ImageFont.load_default()


def draw_horizon_mark(
    draw: ImageDraw.ImageDraw,
    cx: int,
    cy: int,
    *,
    scale: float = 1.0,
) -> tuple[int, int]:
    """Draw ink horizon mark; return (top_y, bottom_y) of the mark."""
    dot_r = int(28 * scale)
    line_w = int(220 * scale)
    line_h = max(8, int(12 * scale))
    gap = int(36 * scale)

    top_y = cy - gap - dot_r
    bottom_y = cy + gap + line_h // 2

    draw.ellipse(
        (cx - dot_r, cy - dot_r - gap, cx + dot_r, cy + dot_r - gap),
        fill=INK,
    )
    draw.rounded_rectangle(
        (
            cx - line_w // 2,
            cy + gap - line_h // 2,
            cx + line_w // 2,
            cy + gap + line_h // 2,
        ),
        radius=line_h // 2,
        fill=INK,
    )
    return top_y, bottom_y


def compute_lockup_layout(draw: ImageDraw.ImageDraw) -> LockupLayout:
    cx = SPLASH_W // 2
    font = _load_bold_font(FONT_SIZE)
    word = "Reflect"

    bbox = draw.textbbox((0, 0), word, font=font)
    text_w = bbox[2] - bbox[0]
    text_h = bbox[3] - bbox[1]

    dot_r = int(28 * MARK_SCALE)
    line_h = max(8, int(12 * MARK_SCALE))
    mark_gap = int(36 * MARK_SCALE)
    mark_height = dot_r * 2 + mark_gap * 2 + line_h

    lockup_height = mark_height + LINE_TO_TEXT_GAP + text_h
    lockup_top = (SPLASH_H - lockup_height) // 2
    mark_cy = lockup_top + dot_r + mark_gap
    mark_bottom = lockup_top + mark_height
    text_x = cx - text_w // 2
    text_y = mark_bottom + LINE_TO_TEXT_GAP - bbox[1]

    return LockupLayout(
        mark_cy=mark_cy,
        mark_scale=MARK_SCALE,
        lockup_top=lockup_top,
        mark_height=mark_height,
        text_x=text_x,
        text_y=text_y,
        word=word,
    )


def generate_app_icon() -> None:
    img = Image.new("RGB", (ICON_SIZE, ICON_SIZE), PAPER)
    draw = ImageDraw.Draw(img)
    draw_horizon_mark(draw, ICON_SIZE // 2, ICON_SIZE // 2, scale=1.15)
    img.save(ICONS / "app_icon.png")


def generate_splash_fullscreen() -> None:
    img = Image.new("RGB", (SPLASH_W, SPLASH_H), PAPER)
    draw = ImageDraw.Draw(img)
    layout = compute_lockup_layout(draw)
    font = _load_bold_font(FONT_SIZE)

    draw_horizon_mark(
        draw,
        SPLASH_W // 2,
        layout.mark_cy,
        scale=layout.mark_scale,
    )
    draw.text(
        (layout.text_x, layout.text_y),
        layout.word,
        fill=INK,
        font=font,
    )
    img.save(ICONS / "splash_fullscreen.png")


def generate_splash_ios_native() -> None:
    """Mark-only splash — same mark position as splash_fullscreen (no wordmark)."""
    img = Image.new("RGB", (SPLASH_W, SPLASH_H), PAPER)
    draw = ImageDraw.Draw(img)
    layout = compute_lockup_layout(draw)

    draw_horizon_mark(
        draw,
        SPLASH_W // 2,
        layout.mark_cy,
        scale=layout.mark_scale,
    )
    img.save(ICONS / "splash_ios_native.png")


def main() -> None:
    ICONS.mkdir(parents=True, exist_ok=True)
    generate_app_icon()
    generate_splash_fullscreen()
    generate_splash_ios_native()
    print(f"Wrote {ICONS / 'app_icon.png'}")
    print(f"Wrote {ICONS / 'splash_fullscreen.png'}")
    print(f"Wrote {ICONS / 'splash_ios_native.png'}")


if __name__ == "__main__":
    main()
