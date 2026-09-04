#let page = (
  title: "Ada Lovelace",
  description: "A small academic homepage generated from Typst content.",
  body: [
    I study programming languages, scientific computing, and the ways notation
    shapes how people think about machines.

    I am currently working at the imaginary *Analytical Engine Institute*.

    = About this site

    Every page on this site is an `index.typ` file. The hierarchies and
    navigations are generated solely from the surrounding directory structure.

    // You can reach me at #link("mailto:ada@example.org")[#text("ada@example.org")].
  ],
)

#title(page.title)
#page.body
