#!/usr/bin/env python3
"""Titled 1200x630 blog covers (v2) for martinlasek.com cards and social previews.

Each cover reuses the post's hero scene from blog_heroes.py on the right, with
a category pill, a bold title and the site name on the left, over a per-post
gradient. Hues follow the /blog grid (newest first, three columns) so no two
neighbours share a hue and no row holds more than two cool tones.

Usage: python3 scripts/blog_covers.py <out-dir>
"""
import importlib.util
import sys
from pathlib import Path
from xml.sax.saxutils import escape as esc

spec = importlib.util.spec_from_file_location("heroes", Path(__file__).with_name("blog_heroes.py"))
heroes = importlib.util.module_from_spec(spec)
spec.loader.exec_module(heroes)

W, H = 1200, 630
FONT = "SF Pro Display, system-ui, -apple-system, Helvetica Neue, Arial, sans-serif"

# slug: (pill, title lines, gradient light, gradient dark, scene bbox x0 y0 x1 y1)
POSTS = {
    "error-app-intents-ssu-training": ("XCODE", ["Fix AppIntents", "build errors"], "#1d4ed8", "#172554", (950, 120, 1470, 538)),
    "get-size-of-view-in-swiftui": ("SWIFTUI", ["Get the size", "of a view"], "#047857", "#064e3b", (955, 120, 1505, 590)),
    "list-and-identifiable-in-swiftui": ("SWIFTUI", ["List and", "Identifiable"], "#7c3aed", "#4c1d95", (975, 60, 1557, 620)),
    "understanding-state-in-swiftui": ("SWIFTUI", ["Understanding", "@State"], "#b45309", "#7c2d12", (985, 70, 1475, 630)),
    "how-to-add-a-placeholder-to-texteditor": ("SWIFTUI", ["TextEditor", "placeholder"], "#4338ca", "#312e81", (945, 84, 1555, 615)),
    "how-to-fix-server-with-unspecified-hostname-not-found": ("MACOS", ["Fix hostname", "not found"], "#be123c", "#881337", (950, 165, 1545, 515)),
    "uihostingcontroller-and-safearea": ("UIKIT + SWIFTUI", ["Ignore the", "safe area"], "#334155", "#0f172a", (968, 70, 1536, 630)),
}

MOTIF_RIGHT, MOTIF_MAX_W, MOTIF_MAX_H = 1120, 500, 530
# Shorter titles leave room for a larger, more legible motif at card size.
MOTIF_W = {
    "how-to-fix-server-with-unspecified-hostname-not-found": 580,
    "how-to-add-a-placeholder-to-texteditor": 580,
    "list-and-identifiable-in-swiftui": 560,
    "uihostingcontroller-and-safearea": 530,
}


def scene_body(slug):
    captured = {}
    heroes.frame = lambda accent, body: captured.setdefault("body", body)
    heroes.SCENES[slug]()
    return captured["body"]


def cover(slug):
    pill, lines, c1, c2, (x0, y0, x1, y1) = POSTS[slug]
    s = min(MOTIF_W.get(slug, MOTIF_MAX_W) / (x1 - x0), MOTIF_MAX_H / (y1 - y0), 1.0)
    tx = MOTIF_RIGHT - x1 * s
    ty = H / 2 - (y0 + y1) / 2 * s
    pill_w = len(pill) * 16.5 + 56
    title_top = 315 - (len(lines) - 1) * 40
    title = "".join(
        f'<text x="80" y="{title_top + 26 + i * 80}" font-family="{FONT}" font-size="68" font-weight="800" '
        f'fill="#ffffff" letter-spacing="-1.5">{esc(line)}</text>' for i, line in enumerate(lines))
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
<defs>
  <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="{c1}"/><stop offset="1" stop-color="{c2}"/></linearGradient>
  <filter id="shadow" x="-40%" y="-40%" width="180%" height="200%">
    <feDropShadow dx="0" dy="16" stdDeviation="20" flood-color="#050a12" flood-opacity=".4"/>
  </filter>
</defs>
<rect width="{W}" height="{H}" fill="url(#bg)"/>
<rect x="80" y="140" width="{pill_w:.0f}" height="52" rx="26" fill="#ffffff" fill-opacity=".18"/>
<text x="{80 + pill_w / 2:.0f}" y="175" font-family="{FONT}" font-size="26" font-weight="600" fill="#ffffff" text-anchor="middle" letter-spacing=".5">{esc(pill)}</text>
{title}
<text x="80" y="560" font-family="{FONT}" font-size="28" font-weight="700" fill="#ffffff" fill-opacity=".85">martinlasek.com</text>
<g transform="translate({tx:.1f} {ty:.1f}) scale({s:.3f})">{scene_body(slug)}</g>
</svg>
'''


if __name__ == "__main__":
    out = Path(sys.argv[1])
    out.mkdir(parents=True, exist_ok=True)
    for slug in POSTS:
        (out / f"{slug}-2.svg").write_text(cover(slug))
        print(slug)
