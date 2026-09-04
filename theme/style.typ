// Theme assets are emitted by Typst as part of the site bundle.
//
// Add web fonts to this array. Each font must declare how it should appear in
// CSS and where its source file lives inside the Typst project root.
#let fonts = (
  // (
  //   family: "Site Font",
  //   source: "/theme/assets/fonts/site-regular.woff2",
  //   output: "assets/theme/fonts/site-regular.woff2",
  //   url: "fonts/site-regular.woff2",
  //   format: "woff2",
  //   weight: 400,
  //   style: "normal",
  // ),
)

// Assign a font family to any site role. A family may come from `fonts` above
// or from fonts already available in the visitor's browser.
#let font-roles = (
  prose: none,
  sans: none,
  serif: none,
  mono: none,
  math: none,
)

#let font-face(font) = (
  "@font-face {\n"
    + "  font-family: \"" + font.family + "\";\n"
    + "  src: url(\"" + font.url + "\") format(\"" + font.format + "\");\n"
    + "  font-display: swap;\n"
    + "  font-style: " + font.style + ";\n"
    + "  font-weight: " + str(font.weight) + ";\n"
    + "}\n"
)

#let font-css = fonts.map(font-face).join("\n")

#let role-declaration(family, variable, fallback) = if family == none {
  ""
} else {
  "  " + variable + ": \"" + family + "\", " + fallback + ";\n"
}

#let role-declarations = (
  role-declaration(font-roles.prose, "--font-prose", "var(--font-sans)")
    + role-declaration(font-roles.sans, "--font-sans", "var(--font-sans-fallback)")
    + role-declaration(font-roles.serif, "--font-serif", "var(--font-serif-fallback)")
    + role-declaration(font-roles.mono, "--font-mono", "var(--font-mono-fallback)")
    + role-declaration(font-roles.math, "--font-math", "var(--font-math-fallback)")
)

#let role-css = if role-declarations == "" {
  ""
} else {
  "\n:root {\n" + role-declarations + "}\n"
}

#let stylesheet = font-css + read("/theme/assets/style.css") + role-css

#let emit-theme-assets() = {
  asset(".nojekyll", "")
  asset("assets/theme/style.css", stylesheet)
  for font in fonts {
    asset(font.output, read(font.source, encoding: none))
  }
}
