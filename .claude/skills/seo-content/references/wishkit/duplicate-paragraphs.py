"""List paragraphs, list items and FAQ questions that appear, word for word, in more than one blog post or compare page.

Run from the repo root:  python3 .claude/skills/seo-content/duplicate-paragraphs.py
Optional:  --min-words 12   (ignore shorter fragments; default 12)

Repeated facts in a pricing bullet are acceptable. Repeated prose is the defect this
check exists to catch (see seo-content/SKILL.md, principle 6).
"""
import glob, html, re, sys
from collections import defaultdict

min_words = 12
if "--min-words" in sys.argv:
    min_words = int(sys.argv[sys.argv.index("--min-words") + 1])

seen = defaultdict(set)
for path in sorted(glob.glob("Resources/Views/Blog/*.leaf") + glob.glob("Resources/Views/Compare/*.leaf")):
    slug = path.split("/")[-1][:-5]
    if slug in ("base", "index"):
        continue
    body = open(path, encoding="utf-8").read()
    body = body[body.find("<!-- ARTICLE -->"):] if "<!-- ARTICLE -->" in body else body
    for block in re.findall(r"<(?:p|li|h3)[^>]*>(.*?)</(?:p|li|h3)>", body, flags=re.S):
        text = html.unescape(re.sub(r"<[^>]+>", "", block))
        text = re.sub(r"\s+", " ", text).strip()
        acceptable = text.startswith(("Pricing:", "Based on publicly", "Based on Canny", "Every WishKit number", "Based on Featurebase", "Based on Upvoty", "Based on Sleekplan"))
        if len(text.split()) >= min_words and not acceptable:
            seen[text].add(slug)

dupes = {t: s for t, s in seen.items() if len(s) > 1}
if not dupes:
    print("No repeated paragraphs across posts.")
    sys.exit(0)

print(f"{len(dupes)} paragraphs appear in more than one post:\n")
for text, slugs in sorted(dupes.items(), key=lambda kv: -len(kv[1])):
    print(f"[{len(slugs)}x] {', '.join(sorted(slugs))}")
    print(f"    {text[:160]}{'...' if len(text) > 160 else ''}\n")
sys.exit(1)
