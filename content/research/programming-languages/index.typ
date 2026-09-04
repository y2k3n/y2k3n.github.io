#let page = (
  title: "Programming Languages",
  description: "Notation, type systems, and tools for scientific programs.",
  body: [
    = Structured scientific documents

    A scientific document can be more than a sequence of formatted pages. Its
    formulas, references, and executable descriptions form a reusable structure.

    For example, the identity

    $ integral_0^infinity e^(-x) dif x = 1 $

    retains its mathematical meaning when Typst exports it to HTML.
  ],
)

#title(page.title)
#page.body
