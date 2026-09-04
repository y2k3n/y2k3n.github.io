# Directory Typst SSG

A deliberately small static site generator. Directories define the content tree,
and Typst modules define the content itself.

## Requirements

- Python 3.11 or newer. The generator only uses the standard library, so no
  `pip install` step or `requirements.txt` is needed.

- Typst 0.15 or newer, available as `typst` on `PATH`.

## Usage

```bash
python3 ssg.py inspect
python3 ssg.py build
python3 ssg.py build --keep-entry  # optionally inspect .ssg/site.typ
python3 -m http.server --directory docs 8000
```

Each build also writes `docs/.nojekyll`, so GitHub Pages can publish the
prebuilt `docs/` directory without running Jekyll. For branch-based Pages
deployment, select the repository branch and `/docs` as the publishing source.

## Content convention

Every directory containing an `index.typ` file is a public content node. Its URL
is derived from its path beneath `content/`:

```text
content/index.typ                    -> /
content/research/index.typ           -> /research/
content/research/languages/index.typ -> /research/languages/
```

Each `index.typ` exports one `page` dictionary:

```typst
#let page = (
  title: "Page title",
  description: "Optional description",
  body: [
    Ordinary *Typst content* goes here.
  ],
)
```

All non-Typst files below `content/` are copied to the same relative location in
the output. Files and directories beginning with `_` or `.` are private. The
generated `assets/theme/` namespace is reserved for theme styles and fonts.

## Custom fonts

Fonts are managed by the Typst theme. See the
[web font guide](theme/assets/fonts/_README.md) for details.

## Controlling HTML layout and styles

Typst's HTML export is still experimental. Commands such as `#align(right)[...]`
and `#text(size: ...)[...]` may be ignored during an HTML build.

For HTML-specific formatting, create an HTML element explicitly and give it an
inline style:

```typst
#html.div(style: "text-align: right; font-size: 0.9rem; line-height: 1.45;")[
  _Student \
  Department \
  University_
]
```

For styles used in more than one place, prefer a class in the Typst source:

```typst
#html.div(class: "education")[
  Education details
]
```

and define its appearance in `theme/assets/style.css`:

```css
.education {
  text-align: right;
  font-size: 0.9rem;
  line-height: 1.45;
}
```

Small reusable helpers can keep content files concise:

```typst
#let align-right(body) = html.div(class: "align-right", body)
#let small(body) = html.span(class: "small", body)

#align-right[Right-aligned content]
#small[Smaller inline content]
```

This project enables the Typst `html` and `bundle` features during the build, so
the `html.*` functions can be used directly in content pages. A raw string
containing HTML is not interpreted as markup; use structured elements such as
`html.div`, `html.span`, `html.p`, and `html.elem` instead.

For equations or diagrams that require Typst's exact visual layout, `html.frame`
can render a small region as inline SVG.
