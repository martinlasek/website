#!/usr/bin/env python3
"""Generate a branded SVG cover image for a WishKit blog post.

Usage:
  python3 generate_cover.py <slug> <PILL> <color1> <color2> "Title line 1" ["Title line 2" ...]

Example:
  python3 generate_cover.py featurebase-pricing PRICING "#0d9488" "#115e59" "Featurebase" "pricing explained"

Writes Public/images/blog/<slug>.svg (run from the repo root).
"""
import sys

FONT = "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"


def cover(slug, pill, c1, c2, lines):
    # 26px semibold caps run ~19px per char incl. letter-spacing; 48 = 24px padding each side.
    pill_w = 48 + len(pill) * 19
    title = ""
    y = 330
    for line in lines:
        title += f'<text x="80" y="{y}" font-family="{FONT}" font-size="68" font-weight="800" fill="#ffffff">{line}</text>\n  '
        y += 84
    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="{c1}"/>
      <stop offset="1" stop-color="{c2}"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="630" fill="url(#bg)"/>
  <g transform="translate(800,120) rotate(3)">
    <rect width="330" height="110" rx="18" fill="#ffffff" opacity="0.14"/>
    <rect x="20" y="25" width="60" height="60" rx="14" fill="#ffffff" opacity="0.22"/>
    <path d="M50 44 l13 19 h-26 z" fill="#ffffff"/>
    <rect x="100" y="34" width="190" height="14" rx="7" fill="#ffffff" opacity="0.55"/>
    <rect x="100" y="62" width="140" height="14" rx="7" fill="#ffffff" opacity="0.30"/>
  </g>
  <g transform="translate(780,270) rotate(-2)">
    <rect width="330" height="110" rx="18" fill="#ffffff" opacity="0.20"/>
    <rect x="20" y="25" width="60" height="60" rx="14" fill="#ffffff" opacity="0.28"/>
    <path d="M50 44 l13 19 h-26 z" fill="#ffffff"/>
    <rect x="100" y="34" width="170" height="14" rx="7" fill="#ffffff" opacity="0.60"/>
    <rect x="100" y="62" width="200" height="14" rx="7" fill="#ffffff" opacity="0.32"/>
  </g>
  <g transform="translate(810,420) rotate(2)">
    <rect width="330" height="110" rx="18" fill="#ffffff" opacity="0.12"/>
    <rect x="20" y="25" width="60" height="60" rx="14" fill="#ffffff" opacity="0.20"/>
    <path d="M50 44 l13 19 h-26 z" fill="#ffffff"/>
    <rect x="100" y="34" width="200" height="14" rx="7" fill="#ffffff" opacity="0.50"/>
    <rect x="100" y="62" width="120" height="14" rx="7" fill="#ffffff" opacity="0.28"/>
  </g>
  <rect x="80" y="140" rx="26" width="{pill_w}" height="52" fill="#ffffff" opacity="0.16"/>
  <text x="{80 + pill_w / 2}" y="175" font-family="{FONT}" font-size="26" font-weight="600" fill="#ffffff" text-anchor="middle" letter-spacing="1">{pill}</text>
  {title}<text x="80" y="560" font-family="{FONT}" font-size="28" font-weight="700" fill="#ffffff" opacity="0.8">wishkit.io</text>
</svg>
'''
    path = f"Public/images/blog/{slug}.svg"
    with open(path, "w") as f:
        f.write(svg)
    print(f"wrote {path}")


if __name__ == "__main__":
    if len(sys.argv) < 6:
        sys.exit(__doc__)
    cover(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5:])
