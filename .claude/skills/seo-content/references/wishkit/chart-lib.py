FONT = "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif"
DARK, GRAY, GREEN, GREENDK, CGRAY, LGRAY = "#0f1419", "#536471", "#0ed180", "#0a8a58", "#64748b", "#cbd5e1"

def t(x, y, size, s, color=DARK, weight=None, anchor=None):
    s = s.replace(": ", ":&#160; ").replace(". ", ".&#160; ").replace(", ", ",&#160; ")
    w = f' font-weight="{weight}"' if weight else ""
    a = f' text-anchor="{anchor}"' if anchor else ""
    return f'<text x="{x}" y="{y}" font-family="{FONT}" font-size="{size}"{w}{a} fill="{color}">{s}</text>'

def chart(path, title, bars, source, bx, bw, gap, scale, height=600, baseline=470, custom=None):
    svg = f'<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="{height}" viewBox="0 0 1200 {height}">\n'
    svg += f'  <rect width="1200" height="{height}" fill="#ecfbf5"/>\n'
    svg += f'  {t(70, 80, 34, title, weight=800)}\n'
    x = bx
    for price, name, sub, value, green in bars:
        h = max(value * scale, 10)
        rx = min(10, h / 2)
        color = GREEN if green else CGRAY
        svg += f'  <rect x="{x}" y="{baseline-h:.0f}" width="{bw}" height="{h:.0f}" rx="{rx:.0f}" fill="{color}"/>\n'
        svg += f'  {t(x+bw/2, baseline-h-14, 26, price, GREENDK if green else DARK, 700, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline+34, 22, name, GREENDK if green else DARK, 700, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline+62, 20, sub, GREENDK if green else GRAY, None, "middle")}\n'
        x += bw + gap
    if custom:
        name, sub = custom
        svg += f'  <rect x="{x}" y="{baseline-320}" width="{bw}" height="320" rx="10" fill="{LGRAY}"/>\n'
        svg += f'  {t(x+bw/2, baseline-320-14, 26, "Custom", DARK, 700, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline-160, 40, "?", CGRAY, 800, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline+34, 22, name, DARK, 700, "middle")}\n'
        svg += f'  {t(x+bw/2, baseline+62, 20, sub, GRAY, None, "middle")}\n'
    svg += f'  <line x1="70" y1="{baseline}" x2="1130" y2="{baseline}" stroke="#cfd9de" stroke-width="2"/>\n'
    svg += f'  {t(70, height-28, 20, source, GRAY)}\n'
    svg += f'  {t(1130, height-28, 20, "wishkit.io", GREENDK, 700, "end")}\n'
    svg += '</svg>\n'
    open(path, "w").write(svg)

