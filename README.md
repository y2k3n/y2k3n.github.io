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
the output. Files and directories beginning with `_` or `.` are private.

## Custom fonts

Fonts are managed by the Typst theme.
See the [web font guide](theme/assets/fonts/_README.md) for details.
