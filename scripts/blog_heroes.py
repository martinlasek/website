#!/usr/bin/env python3
"""Topic-specific 1600x700 detail hero artwork (v2) for martinlasek.com blog posts.

Subjects live between x≈940 and x≈1560 so the left side stays calm for the HTML
heading, and the primary subject stays inside x≈940–1380 for the mobile crop
(object-position 80% center).

Usage: python3 scripts/blog_heroes.py <out-dir>
Then render each SVG and copy it into Public/images/blog/:
  rsvg-convert <slug>-hero-v2.svg -o <slug>-hero-v2.png
  cwebp -q 84 <slug>-hero-v2.png -o Public/images/blog/<slug>-hero-v2.webp
Bump the version in the filenames when changing a published image.
"""
import sys
from pathlib import Path
from xml.sax.saxutils import escape as esc

W, H = 1600, 700
SANS = "SF Pro Text, Helvetica Neue, Arial, sans-serif"
DISPLAY = "SF Pro Display, SF Pro Text, Helvetica Neue, Arial, sans-serif"
MONO = "Menlo, SF Mono, monospace"

INK = "#0f1622"
PANEL = "#16202f"
LINE = "#3a4a62"
SCREEN = "#f4f6fa"
IOS_BLUE = "#2f6fe4"


def t(x, y, s, size, fill, family=SANS, weight=400, anchor="start", extra=""):
    return (f'<text x="{x}" y="{y}" font-family="{family}" font-size="{size}" '
            f'font-weight="{weight}" fill="{fill}" text-anchor="{anchor}" {extra}>{esc(s)}</text>')


def frame(accent, body):
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
<defs>
  <radialGradient id="glow" cx="0.72" cy="0.5" r="0.5">
    <stop offset="0" stop-color="{accent}" stop-opacity=".16"/>
    <stop offset="1" stop-color="{accent}" stop-opacity="0"/>
  </radialGradient>
  <pattern id="dots" width="28" height="28" patternUnits="userSpaceOnUse">
    <circle cx="2" cy="2" r="1.4" fill="#ffffff" opacity=".07"/>
  </pattern>
  <linearGradient id="fade" x1="0" x2="1">
    <stop offset=".45" stop-color="#fff" stop-opacity="0"/>
    <stop offset=".8" stop-color="#fff" stop-opacity="1"/>
  </linearGradient>
  <filter id="grain"><feTurbulence type="fractalNoise" baseFrequency=".9" numOctaves="2" seed="7"/><feColorMatrix values="0 0 0 0 1  0 0 0 0 1  0 0 0 0 1  0 0 0 .5 0"/></filter>
  <mask id="dotmask"><rect width="{W}" height="{H}" fill="url(#fade)"/></mask>
  <filter id="shadow" x="-40%" y="-40%" width="180%" height="200%">
    <feDropShadow dx="0" dy="18" stdDeviation="22" flood-color="#050a12" flood-opacity=".55"/>
  </filter>
</defs>
<rect width="{W}" height="{H}" fill="#1c2738"/>
<rect width="{W}" height="{H}" fill="url(#glow)"/>
<rect width="{W}" height="{H}" filter="url(#grain)" opacity=".05"/>
<rect width="{W}" height="{H}" fill="url(#dots)" mask="url(#dotmask)"/>
{body}
</svg>
'''


def phone(x, y, w=270, h=560, screen=SCREEN, content="", island=True):
    r = 46
    s = f'<g filter="url(#shadow)"><rect x="{x}" y="{y}" width="{w}" height="{h}" rx="{r}" fill="{INK}" stroke="{LINE}" stroke-width="3"/></g>'
    s += f'<rect x="{x+11}" y="{y+11}" width="{w-22}" height="{h-22}" rx="{r-11}" fill="{screen}"/>'
    s += content
    if island:
        s += f'<rect x="{x+w/2-44}" y="{y+24}" width="88" height="26" rx="13" fill="{INK}"/>'
    return s


def code_card(x, y, lines, accent, size=18, pad=22, width=None):
    """lines: list of lists of (text, color) spans."""
    cw = size * 0.602
    longest = max(sum(len(s) for s, _ in ln) for ln in lines)
    w = width or int(longest * cw + pad * 2)
    lh = size * 1.55
    h = int(len(lines) * lh + pad * 2 - (lh - size))
    out = [f'<g filter="url(#shadow)"><rect x="{x}" y="{y}" width="{w}" height="{h}" rx="16" fill="{PANEL}" stroke="{LINE}" stroke-width="2"/></g>',
           f'<rect x="{x}" y="{y+18}" width="4" height="{h-36}" rx="2" fill="{accent}"/>']
    for i, ln in enumerate(lines):
        yy = y + pad + size * 0.8 + i * lh
        spans = "".join(f'<tspan fill="{c}">{esc(s)}</tspan>' for s, c in ln)
        out.append(f'<text x="{x+pad}" y="{yy:.1f}" font-family="{MONO}" font-size="{size}" xml:space="preserve">{spans}</text>')
    return "".join(out), w, h


KW = "#ff7ab2"   # Xcode keyword pink
TY = "#dabaff"   # type
ST = "#ff8170"   # string
PL = "#e6ebf2"   # plain
NUM = "#d9c97c"


# 004 · Understanding @State ----------------------------------------------------
def state():
    a = "#ffbd90"
    px, py = 985, 70
    sx = px + 11
    bx, by, bw = sx + 18, py + 250, 270 - 22 - 36
    content = (
        f'<g opacity=".55"><rect x="{bx}" y="{py+150}" width="{bw}" height="50" rx="6" fill="none" stroke="#8d99ab" stroke-width="2" stroke-dasharray="6 6"/>'
        + t(px + 135, py + 182, "Charmander", 20, "#6b7686", DISPLAY, 500, "middle", 'text-decoration="line-through"')
        + f'<path d="M{px+135} {py+212}v24M{px+127} {py+228}l8 8 8 -8" stroke="#8d99ab" stroke-width="2.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/></g>'
        + f'<rect x="{bx}" y="{by}" width="{bw}" height="58" rx="6" fill="{IOS_BLUE}"/>'
        + t(px + 135, by + 38, "Pikachu", 24, "#ffffff", DISPLAY, 600, "middle")
        + t(px + 135, by + 118, "Switch", 22, IOS_BLUE, DISPLAY, 500, "middle")
        + f'<circle cx="{px+135}" cy="{by+111}" r="34" fill="none" stroke="{a}" stroke-width="3" opacity=".9"/>'
        + f'<circle cx="{px+135}" cy="{by+111}" r="48" fill="none" stroke="{a}" stroke-width="2" opacity=".35"/>'
    )
    cy0 = 150
    card, cw, ch = code_card(1250, cy0, [
        [("@State", a)],
        [("var ", KW), ("pokemonName", PL)],
        [("  = ", PL), ('"Pikachu"', ST)],
    ], a, size=20)
    ay = by + 29
    arrow = (f'<path d="M1330 {cy0+ch+8} C1330 {ay}, 1300 {ay}, {bx+bw+16} {ay}" fill="none" stroke="{a}" stroke-width="3" stroke-dasharray="2 9" stroke-linecap="round"/>'
             f'<path d="M{bx+bw+26} {ay-9} l-12 9 12 9" fill="none" stroke="{a}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>')
    return frame(a, phone(px, py, content=content) + arrow + card)


# 005 · List and Identifiable ---------------------------------------------------
def list_identifiable():
    a = "#bca0ff"
    px, py = 975, 60
    sx, sw = px + 11, 270 - 22
    rows = [("Charmander", "Fire", "#e5484d", 0), ("Squirtle", "Water", IOS_BLUE, 1),
            ("Bulbasaur", "Grass", "#2f9e44", 2), ("Pikachu", "Electric", "#c99400", 3)]
    c = t(sx + sw - 20, py + 86, "+", 30, IOS_BLUE, DISPLAY, 400, "end")
    c += t(sx + 18, py + 126, "Pokémons", 30, "#111722", DISPLAY, 700)
    ry = py + 150
    c += f'<rect x="{sx+12}" y="{ry}" width="{sw-24}" height="{len(rows)*50}" rx="12" fill="#ffffff"/>'
    for i, (name, typ, col, _id) in enumerate(rows):
        y = ry + i * 50
        c += t(sx + 28, y + 31, name, 17, "#111722", DISPLAY, 500)
        c += t(sx + sw - 28, y + 31, typ, 15, col, DISPLAY, 500, "end")
        if i:
            c += f'<rect x="{sx+28}" y="{y}" width="{sw-40}" height="1" fill="#e3e7ee"/>'
    # newly appended row
    ny = ry + len(rows) * 50 + 14
    c += f'<rect x="{sx+12}" y="{ny}" width="{sw-24}" height="50" rx="12" fill="#ffffff" stroke="{a}" stroke-width="3"/>'
    c += t(sx + 28, ny + 31, "Eevee", 17, "#111722", DISPLAY, 500)
    c += t(sx + sw - 28, ny + 31, "Normal", 15, "#6b7686", DISPLAY, 500, "end")
    # id badges floating beside the rows
    badges = ""
    for i in range(len(rows)):
        y = ry + i * 50 + 25
        badges += (f'<rect x="1262" y="{y-15}" width="60" height="30" rx="15" fill="{PANEL}" stroke="{LINE}" stroke-width="2"/>'
                   + t(1292, y + 6, f"id {i}", 14, "#c7d2e2", MONO, 400, "middle")
                   + f'<path d="M1236 {y}h22" stroke="{LINE}" stroke-width="2" stroke-dasharray="3 4"/>')
    y = ny + 25
    badges += (f'<rect x="1262" y="{y-15}" width="60" height="30" rx="15" fill="{a}"/>'
               + t(1292, y + 6, "id 4", 14, "#1b1530", MONO, 700, "middle")
               + f'<path d="M1236 {y}h22" stroke="{a}" stroke-width="2"/>')
    card, _, _ = code_card(1350, 130, [
        [("struct ", KW), ("Pokemon", TY), (":", PL)],
        [("  Identifiable", TY), (" {", PL)],
        [("  let ", KW), ("id", PL), (": ", PL), ("Int", TY)],
        [("}", PL)],
    ], a, size=17)
    return frame(a, phone(px, py, content=c) + badges + card)


# 006 · Get the size of a view --------------------------------------------------
def geometry():
    a = "#7bdad2"
    cx, cy, cw, ch = 955, 120, 450, 330
    s = f'<g filter="url(#shadow)"><rect x="{cx}" y="{cy}" width="{cw}" height="{ch}" rx="26" fill="{SCREEN}"/></g>'
    tw, th = 270, 64
    tx, ty = cx + (cw - tw) / 2, cy + (ch - th) / 2 + 6
    s += f'<rect x="{tx}" y="{ty}" width="{tw}" height="{th}" fill="#e5484d"/>'
    s += t(cx + cw / 2, ty + 46, "Ethan Hunt", 50, "#111722", DISPLAY, 500, "middle")
    # GeometryReader bounds
    s += f'<rect x="{tx-8}" y="{ty-8}" width="{tw+16}" height="{th+16}" fill="none" stroke="{a}" stroke-width="2.5" stroke-dasharray="8 7"/>'
    dark = "#1c6f69"
    # width dimension
    wy = ty - 44
    s += (f'<g stroke="{dark}" stroke-width="3" stroke-linecap="round" fill="none">'
          f'<path d="M{tx} {wy}H{tx+tw}"/><path d="M{tx} {wy-12}v24M{tx+tw} {wy-12}v24"/>'
          f'<path d="M{tx+14} {wy-9}l-14 9 14 9M{tx+tw-14} {wy-9}l14 9 -14 9"/></g>')
    # height dimension
    hx = tx + tw + 40
    s += (f'<g stroke="{dark}" stroke-width="3" stroke-linecap="round" fill="none">'
          f'<path d="M{hx} {ty}V{ty+th}"/><path d="M{hx-12} {ty}h24M{hx-12} {ty+th}h24"/>'
          f'<path d="M{hx-9} {ty+14}l9 -14 9 14M{hx-9} {ty+th-14}l9 14 9 -14"/></g>')
    card, _, _ = code_card(1085, 490, [
        [("print", "#67b7a4"), ("(proxy.size)", PL)],
        [("(86.33, 20.33)", NUM)],
    ], a, size=21, width=420)
    return frame(a, s + card)


# 001 · UIHostingController + SafeArea ------------------------------------------
def safe_area():
    a = "#acdab0"
    red = "#e5484d"
    out = ""
    # ghost "problem" phone: red stops at the safe area
    gx, gy, gs = 1325, 150, .78
    ghost_content = (f'<rect x="{11}" y="{11}" width="{248}" height="{538}" rx="35" fill="#e9edf3"/>'
                     f'<rect x="11" y="70" width="248" height="430" fill="{red}"/>'
                     f'<rect x="60" y="230" width="150" height="100" rx="14" fill="#ffffff"/>')
    out += (f'<g transform="translate({gx} {gy}) scale({gs})" opacity=".45">'
            + phone(0, 0, screen="none", content=ghost_content) + '</g>')
    # main "solution" phone: red runs edge to edge
    px, py = 1010, 70
    c = (f'<rect x="{px+11}" y="{py+11}" width="248" height="538" rx="35" fill="{red}"/>'
         f'<rect x="{px+45}" y="{py+200}" width="180" height="46" rx="12" fill="#ffffff"/>'
         f'<rect x="{px+45}" y="{py+258}" width="180" height="46" rx="12" fill="#ffffff" opacity=".85"/>'
         f'<rect x="{px+45}" y="{py+316}" width="180" height="46" rx="12" fill="#ffffff" opacity=".7"/>')
    guides = ""
    for gy_ in (py + 70, py + 500):
        guides += f'<path d="M{px+11} {gy_}H{px+259}" stroke="#ffffff" stroke-width="2" stroke-dasharray="7 7" opacity=".85"/>'
    c += guides
    c += f'<rect x="{px+95}" y="{py+532}" width="80" height="5" rx="2.5" fill="#ffffff" opacity=".8"/>'
    # outward arrows showing the background extending past the safe area
    arr = (f'<g stroke="{a}" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round" fill="none">'
           f'<path d="M{px-30} {py+120}V{py+30}M{px-40} {py+42}l10 -12 10 12"/>'
           f'<path d="M{px-30} {py+450}V{py+540}M{px-40} {py+528}l10 12 10 -12"/>'
           f'<path d="M{px-30} {py+150}V{py+420}" stroke-dasharray="2 10" opacity=".6"/></g>')
    out += phone(px, py, content=c) + arr
    return frame(a, out)


# 003 · TextEditor placeholder --------------------------------------------------
def texteditor():
    a = "#9abfff"
    iso = "matrix(0.82 0.42 -0.82 0.42 {x} {y})"
    lw, lh = 300, 230

    def layer(x, y, inner, fill, stroke, opacity=1):
        return (f'<g transform="{iso.format(x=x, y=y)}" opacity="{opacity}">'
                f'<rect x="{-lw/2}" y="{-lh/2}" width="{lw}" height="{lh}" rx="18" fill="{fill}" stroke="{stroke}" stroke-width="2.5"/>'
                f'{inner}</g>')
    cx = 1175
    bottom = layer(cx, 470,
                   f'<rect x="{-lw/2+26}" y="{-lh/2+24}" width="3" height="30" fill="{IOS_BLUE}"/>',
                   SCREEN, "#c9d3e1")
    top = layer(cx, 250,
                t(-lw / 2 + 36, -lh / 2 + 48, "Optional", 26, "#c3cad6", DISPLAY, 500),
                "#ffffff", a, .96)
    top = top.replace('fill="#ffffff" stroke', 'fill="#ffffff" fill-opacity=".14" stroke')
    connectors = "".join(
        f'<path d="M{cx+dx} {250+dy}V{470+dy}" stroke="{a}" stroke-width="2" stroke-dasharray="3 8" opacity=".6"/>'
        for dx, dy in ((-lw * .82 / 2 - lh * .82 / 2 + 0, 0), (lw * .82 / 2 + lh * .82 / 2, 0),
                       (0, (lw * .42 + lh * .42) / 2)))
    shadow = f'<ellipse cx="{cx}" cy="{470+110}" rx="230" ry="36" fill="#050a12" opacity=".45"/>'
    chips = ""
    for y, label, col, tcol in ((250, "Text", a, "#111a2c"), (470, "TextEditor", PANEL, "#dbe4f1")):
        x0 = 1418
        w = len(label) * 10.2 + 34
        chips += (f'<path d="M1396 {y}h{x0-1396}" stroke="{LINE}" stroke-width="2"/>'
                  f'<rect x="{x0}" y="{y-18}" width="{w:.0f}" height="36" rx="18" fill="{col}" stroke="{LINE if col == PANEL else col}" stroke-width="2"/>'
                  + t(x0 + w / 2, y + 6, label, 17, tcol, MONO, 700 if col == a else 400, "middle"))
    zs = (f'<rect x="990" y="84" width="96" height="34" rx="17" fill="none" stroke="{a}" stroke-width="2"/>'
          + t(1038, 107, "ZStack", 16, a, MONO, 700, "middle"))
    return frame(a, shadow + connectors + bottom + top + chips + zs)


# 002 · Server hostname could not be found (macOS sandbox) ----------------------
def hostname():
    a = "#f3acbf"
    wx, wy, ww, wh = 950, 165, 470, 350
    s = f'<g filter="url(#shadow)"><rect x="{wx}" y="{wy}" width="{ww}" height="{wh}" rx="16" fill="#242f40" stroke="{LINE}" stroke-width="2"/></g>'
    s += f'<path d="M{wx} {wy+46}H{wx+ww}" stroke="{LINE}" stroke-width="2"/>'
    for i, col in enumerate(("#ff5f57", "#febc2e", "#28c840")):
        s += f'<circle cx="{wx+26+i*22}" cy="{wy+23}" r="7" fill="{col}"/>'
    s += t(wx + ww / 2, wy + 29, "Signing & Capabilities", 15, "#aab6c8", SANS, 500, "middle")
    s += t(wx + 32, wy + 96, "App Sandbox", 22, "#f1f4f9", DISPLAY, 700)
    s += t(wx + 32, wy + 140, "NETWORK", 12, "#8795aa", SANS, 700, "start", 'letter-spacing="1.5"')

    def row(y, label, on):
        r = ""
        if on:
            r += f'<rect x="{wx+18}" y="{y-26}" width="{ww-36}" height="50" rx="10" fill="{a}" fill-opacity=".14" stroke="{a}" stroke-width="2"/>'
            r += f'<rect x="{wx+32}" y="{y-12}" width="22" height="22" rx="5" fill="{a}"/>'
            r += f'<path d="M{wx+37} {y-1}l5 5 8 -10" stroke="#2a1520" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>'
        else:
            r += f'<rect x="{wx+32}" y="{y-12}" width="22" height="22" rx="5" fill="none" stroke="#7d8ca3" stroke-width="2"/>'
        r += t(wx + 68, y + 5, label, 17, "#f1f4f9" if on else "#aab6c8", SANS, 500 if on else 400)
        return r
    s += row(wy + 180, "Incoming Connections (Server)", False)
    s += row(wy + 236, "Outgoing Connections (Client)", True)
    s += row(wy + 292, "Hardware", False).replace("Hardware", "Camera")
    # connection from the window out to a server
    gx, gy = 1500, 250
    s += f'<path d="M{wx+ww-18} {wy+236} C1470 {wy+236}, 1450 {gy+40}, {gx-44} {gy+14}" fill="none" stroke="{a}" stroke-width="3.5" stroke-linecap="round"/>'
    s += (f'<g transform="translate({gx} {gy})" stroke="{a}" stroke-width="3" fill="none">'
          f'<circle r="42" fill="#1c2738"/><ellipse rx="18" ry="42"/><path d="M-42 0H42M-37 -20H37M-37 20H37"/></g>')
    return frame(a, s)


# 007 · AppIntentsSSUTraining build error ---------------------------------------
def app_intents():
    a = "#99baff"
    x, w = 950, 520
    s = ""
    # failing build issue
    s += f'<g filter="url(#shadow)"><rect x="{x}" y="120" width="{w}" height="96" rx="16" fill="#242f40" stroke="{LINE}" stroke-width="2"/></g>'
    s += f'<g opacity=".55"><circle cx="{x+40}" cy="168" r="15" fill="#e5484d"/><path d="M{x+34} 162l12 12M{x+46} 162l-12 12" stroke="#fff" stroke-width="3" stroke-linecap="round"/>'
    s += t(x + 70, 160, "Command AppIntentsSSUTraining failed", 17, "#f1f4f9", SANS, 600)
    s += t(x + 70, 186, "with a nonzero exit code", 17, "#aab6c8", SANS, 400) + '</g>'
    # build settings row
    y = 262
    s += f'<g filter="url(#shadow)"><rect x="{x}" y="{y}" width="{w}" height="170" rx="16" fill="#242f40" stroke="{LINE}" stroke-width="2"/></g>'
    s += f'<rect x="{x+22}" y="{y+22}" width="{w-44}" height="34" rx="9" fill="#1a2433" stroke="{LINE}" stroke-width="1.5"/>'
    s += f'<circle cx="{x+44}" cy="{y+38}" r="7" fill="none" stroke="#8795aa" stroke-width="2"/><path d="M{x+49} {y+43}l6 6" stroke="#8795aa" stroke-width="2" stroke-linecap="round"/>'
    s += t(x + 64, y + 44, "flexible", 16, "#dbe4f1", SANS)
    ry = y + 84
    s += f'<rect x="{x+14}" y="{ry}" width="{w-28}" height="64" rx="10" fill="{a}" fill-opacity=".12" stroke="{a}" stroke-width="2"/>'
    s += t(x + 32, ry + 27, "Enable App Shortcuts", 17, "#f1f4f9", SANS, 500)
    s += t(x + 32, ry + 50, "Flexible Matching", 17, "#f1f4f9", SANS, 500)
    s += f'<rect x="{x+w-112}" y="{ry+15}" width="80" height="34" rx="8" fill="{a}"/>'
    s += t(x + w - 80, ry + 38, "No", 17, "#111a2c", SANS, 700, "middle")
    s += f'<path d="M{x+w-50} {ry+28}l5 -5 5 5M{x+w-50} {ry+36}l5 5 5 -5" stroke="#111a2c" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>'
    # build succeeded
    s += f'<g filter="url(#shadow)"><rect x="{x+150}" y="470" width="{w-150}" height="68" rx="34" fill="#1f3b33" stroke="#3fb68b" stroke-width="2"/></g>'
    s += f'<circle cx="{x+188}" cy="504" r="15" fill="#3fb68b"/><path d="M{x+181} 504l5 5 9 -10" stroke="#fff" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>'
    s += t(x + 214, 511, "Build Succeeded", 19, "#e6f7ef", SANS, 600)
    return frame(a, s)


SCENES = {
    "uihostingcontroller-and-safearea": safe_area,
    "how-to-fix-server-with-unspecified-hostname-not-found": hostname,
    "how-to-add-a-placeholder-to-texteditor": texteditor,
    "understanding-state-in-swiftui": state,
    "list-and-identifiable-in-swiftui": list_identifiable,
    "get-size-of-view-in-swiftui": geometry,
    "error-app-intents-ssu-training": app_intents,
}

if __name__ == "__main__":
    out = Path(sys.argv[1])
    out.mkdir(parents=True, exist_ok=True)
    for slug, fn in SCENES.items():
        (out / f"{slug}-hero-v2.svg").write_text(fn())
        print(slug)
