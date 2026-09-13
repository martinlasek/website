"""Markup helpers for WishKit blog posts. Import from the repo root and pass your own prose.

Usage sketch:
    import importlib.util
    spec = importlib.util.spec_from_file_location("s", ".claude/skills/seo-content/post-scaffold.py")
    s = importlib.util.module_from_spec(spec); spec.loader.exec_module(s)
    body = "\n\n                ".join([s.p("..."), s.h2("..."), s.table([...], [...]), *s.faq([...])])
    open("Resources/Views/Blog/<slug>.leaf", "w").write(s.post("<slug>", title, meta, "Pricing", h1, lede, minutes, body, "Sep 4, 2026", "2026-09-04"))

Every paragraph of prose must be written for the post it is in. Run duplicate-paragraphs.py before shipping.
"""
import html

def link(href, text, ext=False):
    if ext:
        return f'<a href="{href}" target="_blank" rel="nofollow" class="text-primary">{text}</a>'
    return f'<a href="{href}" class="fw-semibold text-primary">{text}</a>'

def check(): return '<i class="bi bi-check-lg text-primary fs-5"></i>'
def cross(): return '<i class="bi bi-x-lg text-secondary"></i>'

def table(headers, rows, first_ps3=True):
    out = ['<div class="card overflow-hidden mt-4 mb-4">', '<div class="table-responsive">', '<table class="table table-striped m-0 align-middle">', '<thead><tr>']
    PS3 = ' class="ps-3"'
    for i, h in enumerate(headers):
        cls = PS3 if i == 0 else ""
        out.append(f'<th scope="col"{cls}>{h}</th>')
    out.append('</tr></thead><tbody>')
    for r in rows:
        out.append('<tr>' + ''.join(f'<td{PS3 if i == 0 else ""}>{c}</td>' for i, c in enumerate(r)) + '</tr>')
    out.append('</tbody></table></div></div>')
    return "\n                ".join(out)

def h2(t): return f'<h2 class="fs-4 fw-bold text-dark mt-5">{t}</h2>'
def h3(t): return f'<h3 class="fs-6 fw-bold text-dark mt-4">{t}</h3>'
def p(t): return f'<p>{t}</p>'
def strong(t): return f'<strong class="text-dark">{t}</strong>'
def ul(items): return '<ul>\n' + '\n'.join(f'                    <li class="mb-2">{i}</li>' for i in items) + '\n                </ul>'
def img(src, alt): return f'<img src="{src}" width="100%" class="rounded-4 mt-3 mb-4" alt="{alt}" />'
def source_note(month="September 2026"): return f'<p class="fs-13">Based on publicly available pricing as of {month}. Spotted something outdated? <a href="mailto:support@wishkit.io" class="text-primary">Let us know.</a></p>'
def price_cards(): return '''<div class="row mt-4">
                    <div class="col"><div class="p-4 rounded-4 text-center" style="background: rgba(14, 209, 128, 0.08);"><p class="text-dark fw-semibold">Free</p><p class="text-primary mb-0"><span class="fs-2">$0</span> <span>/ mo</span></p></div></div>
                    <div class="col"><div class="p-4 rounded-4 text-center" style="background: rgba(14, 209, 128, 0.08);"><p class="text-dark fw-semibold">Premium</p><p class="text-primary mb-0"><span class="fs-2">$15</span> <span>/ mo</span></p></div></div>
                </div>'''

def post(slug, title, meta, category, h1, intro_lede, minutes, body, DATE, DATE_ISO):
    headline = html.unescape(title.replace(" | WishKit", ""))
    return f'''#extend("Blog/base"):
    #export("title"):{title}#endexport
    #export("metaDescription"):{meta}#endexport
    #export("coverImage"):/images/blog/{slug}.png#endexport
    #export("content"):

        <script type="application/ld+json">
        {{
            "@context": "https://schema.org",
            "@type": "BlogPosting",
            "headline": "{headline}",
            "description": "{meta}",
            "image": "https://www.wishkit.io/images/blog/{slug}.png",
            "author": {{ "@type": "Person", "name": "Martin Lasek", "url": "https://www.wishkit.io" }},
            "publisher": {{ "@type": "Organization", "name": "WishKit", "logo": {{ "@type": "ImageObject", "url": "https://www.wishkit.io/images/wishkit-logo.png" }} }},
            "datePublished": "{DATE_ISO}",
            "dateModified": "{DATE_ISO}",
            "mainEntityOfPage": "https://www.wishkit.io/blog/{slug}"
        }}
        </script>

        <!-- HEADER -->

        <div class="container text-center mt-5 pt-4">
            <div class="col-12 col-lg-8 mx-auto">
                <span style="display: inline-block; background: rgba(14, 209, 128, 0.12); color: #0a8a58; font-size: 14px; font-weight: 600; padding: 4px 12px; border-radius: 999px;">{category}</span>
                <h1 class="font-extra-bold fs-1 mt-3">{h1}</h1>
                <p class="fs-18 mt-3 text-secondary">{intro_lede}</p>
                <p class="fs-13 text-secondary mt-3">By Martin Lasek · {DATE} · {minutes} min read</p>
            </div>
        </div>

        <!-- COVER -->

        <div class="container mt-4">
            <div class="col-12 col-lg-8 mx-auto">
                <img src="/images/blog/{slug}.png" width="100%" class="rounded-4" alt="{html.unescape(h1)}" />
            </div>
        </div>

        <!-- ARTICLE -->

        <div class="container mt-5">
            <div class="col-12 col-lg-7 mx-auto text-secondary">

                {body}

            </div>
        </div>

        <div class="mt-5"></div>

        #extend("Compare/Partials/cta-band"):#endextend

    #endexport
#endextend
'''


def quick_table(rows):
    return table(["Tool", "Free plan", "Entry paid price", "Best for"], rows)

def faq(items):
    return [h2("Frequently asked questions")] + [x for q, a in items for x in (h3(q), p(a))]
