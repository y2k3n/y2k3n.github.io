# Web fonts

The Typst theme manages web fonts as bundle assets. Python does not inspect the
font files, and they do not need to be installed on the build machine. The
browser loads them through generated `@font-face` rules.

## Add a font

1. Put the font files in this directory. WOFF2 is recommended for the web.
2. Add one entry for each face to the `fonts` array in `theme/style.typ`.
3. Assign the family to one or more entries in `font-roles`.
4. Run `python3 ssg.py build`.

For example, first add these files:

```text
theme/assets/fonts/site-regular.woff2
theme/assets/fonts/site-bold.woff2
```

Then configure their faces:

```typst
#let fonts = (
  (
    family: "Site Font",
    source: "/theme/assets/fonts/site-regular.woff2",
    output: "_assets/fonts/site-regular.woff2",
    url: "fonts/site-regular.woff2",
    format: "woff2",
    weight: 400,
    style: "normal",
  ),
  (
    family: "Site Font",
    source: "/theme/assets/fonts/site-bold.woff2",
    output: "_assets/fonts/site-bold.woff2",
    url: "fonts/site-bold.woff2",
    format: "woff2",
    weight: 700,
    style: "normal",
  ),
)
```

All faces belonging to one family should use the same `family` value. The other
fields have the following meanings:

- `source`: Project-root-relative path read by Typst.
- `output`: Destination path in the generated bundle.
- `url`: URL relative to `docs/_assets/style.css`; it must refer to the same
  file as `output`.
- `format`: CSS font format, such as `woff2`, `woff`, `truetype`, or `opentype`.
- `weight`: CSS weight from 1 to 1000, normally 400 for regular and 700 for bold.
- `style`: CSS style such as `normal`, `italic`, or `oblique`.

## Assign font roles

Declaring a face makes it available to the browser but does not apply it. Use
`font-roles` in `theme/style.typ` to decide where each family is used:

```typst
#let font-roles = (
  prose: "Site Font",
  sans: none,
  serif: "Site Font",
  mono: none,
  math: none,
)
```

- `prose`: Ordinary page text.
- `sans`: Page shell, headings, navigation, tables, and captions.
- `serif`: Quotations.
- `mono`: Code, preformatted text, keyboard input, and samples.
- `math`: HTML mathematics.

Set a role to `none` to retain its default fallback stack. An unconfigured
`prose` role follows `sans`. A role may name a system font without a bundled
face, but visitors will only see it if that font is installed on their device.

## Build output

During a build, Typst:

1. Generates one `@font-face` rule per configured face.
2. Combines those rules with `theme/assets/style.css`.
3. Writes the result to `docs/_assets/style.css`.
4. Writes the fonts to their configured bundle paths, normally
   `docs/_assets/fonts/`.

If `fonts` is empty and all roles are `none`, no fonts are bundled and the site
uses its system fallback stacks. Only bundle fonts whose licenses permit web
embedding and redistribution.
