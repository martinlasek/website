import math

FONT = "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"
DARK, GRAY, GREEN, GREENDK = "#0f1419", "#536471", "#0ed180", "#0a8a58"
BARGRAY, LIGHTBAR, BG = "#64748b", "#cbd5e1", "#ecfbf5"

def t(x, y, size, s, color=DARK, weight=None, anchor=None):
    # librsvg renders the space after ':' and '.' nearly zero-width at heavy weights
    s = s.replace(": ", ":&#160; ").replace(". ", ".&#160; ")
    w = f' font-weight="{weight}"' if weight else ""
    a = f' text-anchor="{anchor}"' if anchor else ""
    return f'<text x="{x}" y="{y}" font-family="{FONT}" font-size="{size}"{w}{a} fill="{color}">{s}</text>'

def frame(title, height=580):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="{height}" viewBox="0 0 1200 {height}">\n'
            f'  <rect width="1200" height="{height}" fill="{BG}"/>\n  {t(70, 80, 34, title, DARK, 800)}\n')

def footer(caption, height=580):
    return f'  {t(70, height-30, 20, caption, GRAY)}\n  {t(1130, height-30, 20, "wishkit.io", GREENDK, 700, "end")}\n</svg>\n'

def bar_chart(name, title, bars, maxval, caption, custom_label=None):
    # bars: list of (value_label, axis_label, value, kind) kind in green|gray|custom
    n = len(bars)
    gap = 58 if n >= 6 else 80
    bw = (1020 - (n-1)*gap) // n
    bx = (1200 - (n*bw + (n-1)*gap)) // 2
    baseline, scale = 470, 300.0 / maxval
    svg = frame(title)
    x = bx
    for vlabel, alabel, v, kind in bars:
        if kind == "custom":
            h = 320
            svg += f'  <rect x="{x}" y="{baseline-h}" width="{bw}" height="{h}" rx="10" fill="{LIGHTBAR}"/>\n'
            svg += f'  {t(x+bw/2, baseline-h/2+14, 40, "?", BARGRAY, 800, "middle")}\n'
        else:
            h = max(v*scale, 10)
            rx = min(10, h/2)
            fill = GREEN if kind == "green" else BARGRAY
            svg += f'  <rect x="{x}" y="{baseline-h:.0f}" width="{bw}" height="{h:.0f}" rx="{rx:.0f}" fill="{fill}"/>\n'
        pc = GREENDK if kind == "green" else DARK
        lc = GREENDK if kind == "green" else GRAY
        lw = 700 if kind == "green" else None
        top = baseline - (320 if kind == "custom" else max(v*scale, 10))
        svg += f'  {t(x+bw/2, top-14, 26, vlabel, pc, 700, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline+34, 23, alabel, lc, lw, "middle")}\n'
        x += bw + gap
    svg += f'  <line x1="80" y1="{baseline}" x2="1120" y2="{baseline}" stroke="#cfd9de" stroke-width="2"/>\n'
    svg += footer(caption)
    open(f"Public/images/blog/{name}.svg", "w").write(svg)

# A: Featurebase seat multiplication
bar_chart("featurebase-pricing-seat-chart",
    "Featurebase middle tier: monthly price by team size",
    [("$15", "WishKit", 15, "green"), ("$59", "1 seat", 59, "gray"), ("$118", "2 seats", 118, "gray"),
     ("$236", "4 seats", 236, "gray"), ("$472", "8 seats", 472, "gray")],
    472, "Featurebase $59/seat middle tier, publicly reported Aug 2026 · WishKit Premium is flat")

# B: UserVoice tiers
bar_chart("uservoice-pricing-tiers-chart",
    "Monthly price: UserVoice tiers vs WishKit",
    [("$15", "WishKit", 15, "green"), ("$699", "Essentials", 699, "gray"), ("$999", "Pro", 999, "gray"),
     ("$1,499", "Premium", 1499, "gray"), ("Custom", "Today", 0, "custom")],
    1499, "Legacy published UserVoice tiers · current pricing is custom, reportedly from ~$16,000/yr · August 2026")

# C: Canny alternatives entry prices
bar_chart("best-canny-alternatives-price-chart",
    "Entry paid plan per month across the field",
    [("~$13", "Sleekplan", 13, "gray"), ("$15", "WishKit", 15, "green"), ("~$25", "Frill", 25, "gray"),
     ("$29", "Featurebase", 29, "gray"), ("$50", "Canny", 50, "gray"), ("Custom", "UserVoice", 0, "custom")],
    50, "Featurebase is per seat · Canny billed annually · publicly reported pricing, August 2026")

# E: UserVoice yearly
bar_chart("best-uservoice-alternatives-yearly-chart",
    "What a year costs: UserVoice vs the alternatives",
    [("~$16K", "UserVoice", 16000, "gray"), ("$600", "Canny", 600, "gray"), ("$348", "Featurebase", 348, "gray"),
     ("~$300", "Frill", 300, "gray"), ("$156", "Sleekplan", 156, "gray"), ("$150", "WishKit", 150, "green")],
    16000, "Entry paid plans billed yearly · Featurebase per seat · reported UserVoice entry quotes · August 2026")

# D: billing model map
svg = frame("Who bills you for what")
cols = [
    ("Flat price", [("WishKit · $15/mo", True), ("features.vote · $9/mo", False), ("Sleekplan · ~$13/mo", False), ("Frill · ~$25/mo", False)]),
    ("Per seat", [("Featurebase", False), ("$29-$99 per teammate", False), ("+ $0.29/AI resolution", False)]),
    ("Per tracked user", [("Canny", False), ("$50/mo at 100 users", False), ("~$579/mo at 1,250", False)]),
    ("Custom quote", [("UserVoice", False), ("sales call required", False), ("reportedly ~$16K/yr", False)]),
]
x = 70
for head, rows in cols:
    svg += f'  <rect x="{x}" y="130" width="250" height="330" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
    svg += f'  {t(x+24, 180, 25, head, DARK, 800)}\n'
    svg += f'  <line x1="{x+24}" y1="200" x2="{x+226}" y2="200" stroke="#e1e5ea" stroke-width="2"/>\n'
    ry = 244
    for label, hl in rows:
        c = GREENDK if hl else GRAY
        w = 700 if hl else None
        svg += f'  {t(x+24, ry, 21, label, c, w)}\n'
        ry += 44
    x += 270
svg += f'  {t(70, 520, 22, "The model decides how your bill grows: with your team, with your users, or not at all.", GRAY)}\n'
svg += footer("Publicly reported pricing, August 2026")
open("Public/images/blog/best-featurebase-alternatives-billing-map.svg", "w").write(svg)

# F: two ways a bill grows
svg = frame("Two ways a feedback bill grows")
svg += f'  <rect x="70" y="130" width="510" height="280" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
svg += f'  {t(100, 182, 25, "Featurebase: per teammate", DARK, 800)}\n'
for i in range(4):
    cx = 130 + i*56
    svg += f'  <circle cx="{cx}" cy="240" r="13" fill="{BARGRAY}"/>\n'
    svg += f'  <path d="M{cx-20} 282 a20 20 0 0 1 40 0 z" fill="{BARGRAY}"/>\n'
svg += f'  {t(100, 340, 27, "4 seats &#215; $59 = $236/mo", DARK, 700)}\n'
svg += f'  {t(100, 376, 21, "Grows when you hire", GRAY)}\n'
svg += f'  <rect x="620" y="130" width="510" height="280" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
svg += f'  {t(650, 182, 25, "Canny: per tracked user", DARK, 800)}\n'
for r in range(3):
    for c in range(9):
        svg += f'  <circle cx="{666 + c*26}" cy="{226 + r*26}" r="7" fill="{BARGRAY}"/>\n'
svg += f'  {t(650, 340, 27, "700 users &#8776; $379/mo", DARK, 700)}\n'
svg += f'  {t(650, 376, 21, "Grows when your product succeeds", GRAY)}\n'
svg += f'  <rect x="70" y="440" width="1060" height="64" rx="16" fill="rgba(14,209,128,0.15)"/>\n'
svg += f'  {t(600, 480, 25, "WishKit: $15/mo flat, either way", GREENDK, 800, "middle")}\n'
svg += footer("Publicly reported pricing, August 2026")
open("Public/images/blog/featurebase-vs-canny-billing-paths.svg", "w").write(svg)

# G: *Kit landscape
svg = frame("The *Kit landscape at a glance")
svg += f'  <rect x="70" y="130" width="440" height="330" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
svg += f'  {t(100, 182, 25, "Ships with iOS", DARK, 800)}\n'
apple = ["UIKit", "StoreKit", "HealthKit", "MapKit", "CloudKit", "WidgetKit"]
for i, k in enumerate(apple):
    svg += f'  {t(100 + (i % 2) * 200, 232 + (i // 2) * 52, 23, k, GRAY)}\n'
svg += f'  {t(100, 430, 20, "Built in, no dependency needed", GRAY)}\n'
svg += f'  <rect x="550" y="130" width="580" height="330" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
svg += f'  {t(580, 182, 25, "Third-party", DARK, 800)}\n'
tp = [("ChatKit", "feedback chat / AI chat UIs", False), ("SwiftyStoreKit", "in-app purchases (legacy)", False),
      ("PermissionsKit", "permission requests", False), ("WishKit", "feature requests &amp; voting", True)]
ry = 236
for name, desc, hl in tp:
    nc = GREENDK if hl else DARK
    svg += f'  {t(580, ry, 23, name, nc, 700)}\n'
    svg += f'  {t(790, ry, 22, desc, GREENDK if hl else GRAY)}\n'
    ry += 56
svg += footer("Names collide: always check which product a *Kit actually is")
open("Public/images/blog/best-ios-kit-sdks-landscape.svg", "w").write(svg)

# H: feedback loop
svg = frame("The feedback loop")
nodes = [("Collect requests", 600, 155), ("Prioritize by votes", 935, 300), ("Ship the winner", 600, 445), ("Close the loop", 265, 300)]
for label, cx, cy in nodes:
    svg += f'  <rect x="{cx-115}" y="{cy-31}" width="230" height="62" rx="16" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
    svg += f'  {t(cx, cy+8, 23, label, DARK, 700, "middle")}\n'
def arrow_tri(px, py, dx, dy, size=18, width=7.5):
    L = math.hypot(dx, dy); ux, uy = dx/L, dy/L; nx, ny = -uy, ux
    bx, by = px - size*ux, py - size*uy
    return (f'<path d="M{px:.1f} {py:.1f} L{bx+width*nx:.1f} {by+width*ny:.1f} '
            f'L{bx-width*nx:.1f} {by-width*ny:.1f} Z" fill="{GREENDK}"/>')

arrows = [("M 730 175 Q 870 200 920 262", (920, 262), (50, 62)),
          ("M 920 340 Q 870 400 730 428", (730, 428), (-140, 28)),
          ("M 470 428 Q 330 400 280 340", (280, 340), (-50, -60)),
          ("M 280 262 Q 330 200 470 175", (470, 175), (140, -25))]
for path, (hx, hy), (dx, dy) in arrows:
    svg += f'  <path d="{path}" stroke="{GREENDK}" stroke-width="2.5" fill="none"/>\n'
    svg += f'  {arrow_tri(hx, hy, dx, dy)}\n'
svg += f'  {t(600, 308, 22, "repeat", GRAY, None, "middle")}\n'
svg += footer("Users who see their requests ship keep giving feedback")
open("Public/images/blog/why-customer-feedback-matters-loop.svg", "w").write(svg)

print("all written")
