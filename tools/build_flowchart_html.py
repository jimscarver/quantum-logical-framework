#!/usr/bin/env python3
"""Build FlowChart.html (print-to-PDF-ready) from FlowChart.md.

Unlike GitHub, a browser runs current Mermaid and honours `click` directives, so the
generated HTML has clickable diagram nodes (internal section jumps + external doc URLs),
a linked table of contents, and an introduction. Open it in a browser and
File -> Print -> Save as PDF to get a PDF with working internal and external links.

No third-party deps (pandoc/LaTeX/Chromium not required here — the browser renders).
"""
import re, html, json, pathlib

REPO = "https://github.com/jimscarver/quantum-logical-framework/blob/main"
ROOT = pathlib.Path(__file__).resolve().parent.parent
MD = ROOT / "FlowChart.md"
OUT = ROOT / "FlowChart.html"
CLICKMAPS = json.loads((pathlib.Path("/tmp/clickmaps.json")).read_text()) \
    if pathlib.Path("/tmp/clickmaps.json").exists() else [{} for _ in range(11)]

def gh_anchor(heading: str) -> str:
    a = heading.strip().lower()
    a = re.sub(r"[^\w\s-]", "", a)
    return a.replace(" ", "-")

def md_links_to_html(text: str) -> str:
    """Minimal inline-markdown -> HTML, resolving relative .md links to full GitHub URLs."""
    def link(m):
        label, url = m.group(1), m.group(2).strip()
        if url.startswith("#") or url.startswith("http") or url.startswith("mailto"):
            href = url
        else:  # relative repo path -> full GitHub URL
            href = f"{REPO}/{url}"
            if url.endswith((".md", ".lean", ".py")) is False:
                href = f"{REPO}/{url}"
        ext = "" if url.startswith("#") else ' target="_blank" rel="noopener"'
        return f'<a href="{html.escape(href)}"{ext}>{label}</a>'
    # links first (before escaping), using placeholders
    parts, last, out = [], 0, []
    for m in re.finditer(r"\[([^\]]+)\]\(([^)]+)\)", text):
        out.append(html.escape(text[last:m.start()]))
        out.append(link(m))
        last = m.end()
    out.append(html.escape(text[last:]))
    s = "".join(out)
    s = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", s)
    s = re.sub(r"(?<!\w)\*([^*]+)\*(?!\w)", r"<em>\1</em>", s)
    s = re.sub(r"`([^`]+)`", r"<code>\1</code>", s)
    s = s.replace("&amp;rarr;", "&rarr;").replace("&amp;middot;", "&middot;")
    s = s.replace("&amp;", "&")  # restore entities we intentionally use
    return s

raw = MD.read_text()

# split off the leading title/intro (everything before the first "## ")
head, _, rest = raw.partition("\n## ")
rest = "## " + rest
# section chunks
chunks = re.split(r"(?=^## )", rest, flags=re.M)

sections = []
for c in chunks:
    mh = re.match(r"## (.+)", c)
    if not mh:
        continue
    title = mh.group(1).strip()
    anchor = gh_anchor(title)
    mm = re.search(r"```mermaid\n(.*?)```", c, re.S)
    diagram = mm.group(1) if mm else ""
    # body text = everything after the mermaid block (connectors / open / prose), minus "---"
    after = c[mm.end():] if mm else c[mh.end():]
    body_lines = [ln for ln in after.splitlines() if ln.strip() and ln.strip() != "---"]
    sections.append({"title": title, "anchor": anchor, "diagram": diagram, "body": body_lines})

# map a domain section's leading number -> its anchor (for master-map node links)
num_anchor = {}
for s in sections:
    mnum = re.match(r"(\d+)\.", s["title"])
    if mnum:
        num_anchor[int(mnum.group(1))] = s["anchor"]

def add_clicks(idx, diagram):
    """Append click directives so nodes are clickable in the browser/PDF."""
    lines = []
    if idx == 0:  # master map: domain nodes -> internal section anchors
        for nid in re.findall(r'\bD(\d+)\["', diagram):
            n = int(nid)
            if n in num_anchor:
                lines.append(f'  click D{n} "#{num_anchor[n]}"')
        lines.append(f'  click S "{REPO}/README.md" _blank')
    else:  # sub-charts: reuse original node->doc map (skip removed hub H*), external URLs
        cm = CLICKMAPS[idx] if idx < len(CLICKMAPS) else {}
        present = set(re.findall(r'\b([A-Za-z]\w*)\["', diagram))
        for nid, tgt in cm.items():
            if nid.startswith("H") or nid not in present:
                continue
            if tgt.startswith("#"):
                continue
            lines.append(f'  click {nid} "{REPO}/{tgt}" _blank')
    return diagram.rstrip() + "\n" + "\n".join(lines) + "\n" if lines else diagram

# ---- assemble HTML ----
intro = """
<p>This is a one-page visual map of the <strong>Quantum Logical Framework (QLF)</strong> &mdash; a
formal proof system, machine-verified in Lean&nbsp;4 across 89 modules with zero <code>sorry</code>,
that derives quantum mechanics and spacetime from a single selection principle: <em>Zero Free Action
(ZFA) balance</em>. Every chart below shows one domain; the <strong>boxes are clickable</strong>
(this is a PDF/HTML perk &mdash; GitHub disables Mermaid node links), and each <strong>Open</strong>
line lists the documents that derive that domain.</p>
<p><strong>How to read it:</strong> one substrate &rarr; four families &rarr; ten domains &rarr; the
individual results. Click a box to jump to its section or open its source document; use the table of
contents to navigate. To save as PDF: open this file in a browser, then File &rarr; Print &rarr;
Save&nbsp;as&nbsp;PDF (keep &ldquo;Background graphics&rdquo; on).</p>
"""

toc = "\n".join(
    f'<li><a href="#{s["anchor"]}">{html.escape(s["title"])}</a></li>' for s in sections
)

body_html = []
for i, s in enumerate(sections):
    paras = "\n".join(f"<p>{md_links_to_html(ln)}</p>" for ln in s["body"])
    fig = ""
    if s["diagram"].strip():
        diagram = add_clicks(i, s["diagram"])
        fig = f'<pre class="mermaid">{html.escape(diagram)}</pre>'
    body_html.append(f"""
<section id="{s['anchor']}">
  <h2>{html.escape(s['title'])} <a class="top" href="#top">&uarr; top</a></h2>
  {fig}
  {paras}
</section>""")

doc = f"""<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>QLF Flow Chart &mdash; a visual map of the framework</title>
<style>
  body {{ font-family: -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
         max-width: 60rem; margin: 2rem auto; padding: 0 1.2rem; color: #1b1b1b; line-height: 1.5; }}
  h1 {{ font-size: 1.7rem; margin-bottom: .2rem; }}
  h2 {{ font-size: 1.25rem; margin-top: 2.2rem; border-bottom: 1px solid #ddd; padding-bottom: .2rem; }}
  a {{ color: #0b5cad; text-decoration: none; }}
  a:hover {{ text-decoration: underline; }}
  a.top {{ font-size: .7rem; font-weight: normal; color: #888; margin-left: .5rem; }}
  code {{ background: #f3f3f3; padding: .05em .35em; border-radius: 4px; font-size: .92em; }}
  .mermaid {{ background: #fafafa; border: 1px solid #eee; border-radius: 6px; padding: .8rem;
             text-align: center; overflow-x: auto; }}
  nav {{ background: #f7f9fb; border: 1px solid #e3e8ee; border-radius: 8px; padding: .6rem 1.2rem; }}
  nav ol {{ columns: 2; margin: .3rem 0; }}
  .intro p {{ margin: .5rem 0; }}
  footer {{ margin-top: 3rem; font-size: .85rem; color: #666; border-top: 1px solid #ddd; padding-top: .8rem; }}
  @media print {{
    section {{ break-inside: avoid; }}
    h2 {{ break-after: avoid; }}
    a {{ color: #0b5cad; }}
    nav {{ break-inside: avoid; }}
  }}
</style>
</head><body id="top">
<h1>QLF Flow Chart &mdash; a visual map of the framework</h1>
<div class="intro">{intro}</div>
<nav><strong>Contents</strong><ol>{toc}</ol></nav>
{''.join(body_html)}
<footer>
  Generated from <a href="{REPO}/FlowChart.md" target="_blank" rel="noopener">FlowChart.md</a>.
  Project: <a href="https://github.com/jimscarver/quantum-logical-framework" target="_blank" rel="noopener">jimscarver/quantum-logical-framework</a>.
  Diagrams render via Mermaid; boxes and links are clickable in the browser and in the printed PDF.
</footer>
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
  mermaid.initialize({{ startOnLoad: true, securityLevel: 'loose', theme: 'neutral', flowchart: {{ useMaxWidth: true }} }});
</script>
</body></html>
"""

OUT.write_text(doc)
print(f"wrote {OUT} ({len(doc)} bytes), {len(sections)} sections")
