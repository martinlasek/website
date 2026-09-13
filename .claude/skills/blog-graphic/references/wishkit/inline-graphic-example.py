FONT = "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"
DARK, GRAY, GREEN, GREENDK = "#0f1419", "#536471", "#0ed180", "#0a8a58"

def t(x, y, size, s, color=DARK, weight=None, anchor=None):
    # librsvg renders the space after ':' and '.' nearly zero-width at heavy weights
    s = s.replace(": ", ":&#160; ").replace(". ", ".&#160; ")
    w = f' font-weight="{weight}"' if weight else ""
    a = f' text-anchor="{anchor}"' if anchor else ""
    return f'<text x="{x}" y="{y}" font-family="{FONT}" font-size="{size}"{w}{a} fill="{color}">{s}</text>'

# ---- Graphic 1: Canny Growth price staircase with WishKit bar ----
bars = [
    ("$15", "WishKit", 15, "#0ed180", "greendk"),
    ("$79", "100", 79, "#64748b", "gray"),
    ("$129", "200", 129, "#64748b", "gray"),
    ("$379", "700", 379, "#64748b", "gray"),
    ("$579", "1,250", 579, "#64748b", "gray"),
]
scale = 300 / 579.0
bx, bw, gap = 100, 118, 58
baseline = 470
svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="580" viewBox="0 0 1200 580">
  <rect width="1200" height="580" fill="#ecfbf5"/>
  {t(70, 80, 34, "Monthly price by tracked users: Canny Growth vs WishKit", weight=800)}
'''
x = bx
for price, label, v, color, style in bars:
    h = max(v * scale, 10)
    rx = min(10, h / 2)
    svg += f'  <rect x="{x}" y="{baseline-h:.0f}" width="{bw}" height="{h:.0f}" rx="{rx:.0f}" fill="{color}"/>\n'
    pcolor = GREENDK if style == "greendk" else DARK
    lcolor = GREENDK if style == "greendk" else GRAY
    lweight = 700 if style == "greendk" else None
    svg += f'  {t(x+bw/2, baseline-h-14, 26, price, pcolor, 700, "middle")}\n'
    svg += f'  {t(x+bw/2, baseline+34, 24, label, lcolor, lweight, "middle")}\n'
    x += bw + gap
# custom bar
svg += f'  <rect x="{x}" y="{baseline-320}" width="{bw}" height="320" rx="10" fill="#cbd5e1"/>\n'
svg += f'  {t(x+bw/2, baseline-320-14, 26, "Custom", DARK, 700, "middle")}\n'
svg += f'  {t(x+bw/2, baseline-160, 40, "?", "#64748b", 800, "middle")}\n'
svg += f'  {t(x+bw/2, baseline+34, 24, "5,000+", GRAY, None, "middle")}\n'
svg += f'  <line x1="80" y1="{baseline}" x2="1120" y2="{baseline}" stroke="#cfd9de" stroke-width="2"/>\n'
svg += f'  {t(70, 550, 20, "Publicly reported pricing, August 2026 · WishKit Premium is flat with unlimited users", GRAY)}\n'
svg += f'  {t(1130, 550, 20, "wishkit.io", GREENDK, 700, "end")}\n'
svg += '</svg>\n'
open("Public/images/blog/canny-pricing-growth-chart.svg", "w").write(svg)

# ---- Graphic 2: scattered channels -> one board ----
cards = [("App Store reviews", "star"), ("Support emails", "mail"), ("Posts on X", "x"), ("TestFlight notes", "plane")]
rows = [("412", "Dark mode", "My eyes would love a dark theme", "Planned", True),
        ("278", "Home screen widgets", "Glanceable stats on the home screen", "", False),
        ("95", "iCloud sync", "Keep my entries in sync across devices", "In progress", False)]
svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="560" viewBox="0 0 1200 560">
  <rect width="1200" height="560" fill="#ecfbf5"/>
  {t(70, 80, 34, "Four scattered channels. One ranked list.", weight=800)}
'''
y = 130
for label, icon in cards:
    svg += f'  <rect x="70" y="{y}" width="320" height="76" rx="14" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
    cx, cy = 110, y+38
    if icon == "star":
        svg += f'  <path d="M{cx} {cy-14} l4.2 8.6 9.5 1.4 -6.9 6.7 1.6 9.4 -8.4 -4.4 -8.4 4.4 1.6 -9.4 -6.9 -6.7 9.5 -1.4 z" fill="#f59e0b"/>\n'
    elif icon == "mail":
        svg += f'  <rect x="{cx-14}" y="{cy-10}" width="28" height="20" rx="4" fill="none" stroke="#64748b" stroke-width="2.5"/>\n'
        svg += f'  <path d="M{cx-14} {cy-8} l14 10 14 -10" fill="none" stroke="#64748b" stroke-width="2.5"/>\n'
    elif icon == "x":
        svg += f'  {t(cx, cy+10, 30, "&#120143;", DARK, 800, "middle")}\n'
    else:
        svg += f'  <path d="M{cx-14} {cy+6} l28 -12 -12 18 -4 -7 z" fill="#3b82f6"/>\n'
    svg += f'  {t(150, y+46, 25, label, DARK, 600)}\n'
    svg += f'  <path d="M400 {y+38} C 470 {y+38} 490 320 540 320" stroke="#9fb0bc" stroke-width="3" fill="none"/>\n'
    y += 100
svg += f'  <path d="M562 320 l-22 -13 v26 z" fill="#9fb0bc"/>\n'
# board
svg += f'  <rect x="575" y="120" width="555" height="370" rx="18" fill="#ffffff" stroke="#e1e5ea" stroke-width="2"/>\n'
svg += f'  {t(615, 178, 27, "Feature Requests", DARK, 800)}\n'
for i, (votes, title, desc, status, hl) in enumerate(rows):
    top = 204 + i*88
    tile = GREEN if hl else "#f1f2f5"
    fg = "#ffffff" if hl else DARK
    svg += f'  <rect x="615" y="{top+14}" width="56" height="56" rx="14" fill="{tile}"/>\n'
    svg += f'  <path d="M{643-8} {top+36} l8 -9 8 9" stroke="{fg}" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>\n'
    svg += f'  {t(643, top+59, 19, votes, fg, 700, "middle")}\n'
    svg += f'  {t(695, top+40, 25, title, DARK, 700)}\n'
    svg += f'  {t(695, top+70, 20, desc, GRAY)}\n'
    if status:
        stw = 30 + len(status)*11
        svg += f'  <rect x="{1106-stw}" y="{top+13}" width="{stw}" height="34" rx="17" fill="rgba(14,209,128,0.12)"/>\n'
        svg += f'  {t(1106-stw/2, top+36, 18, status, GREENDK, 600, "middle")}\n'
    if i < len(rows)-1:
        svg += f'  <line x1="615" y1="{top+88}" x2="1106" y2="{top+88}" stroke="#eef0f2" stroke-width="2"/>\n'
svg += f'  {t(575, 530, 22, "Votes rank the roadmap for you", GRAY)}\n' 
svg += f'  {t(1130, 530, 20, "wishkit.io", GREENDK, 700, "end")}\n'
svg += '</svg>\n'
open("Public/images/blog/ios-feature-requests-channels.svg", "w").write(svg)
print("written")
