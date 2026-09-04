#let publication(
  title,
  authors,
  year,
  venue,
  publisher: none,
  location: none,
  pages: none,
  links: (),
) = {
  let publication-info = (publisher, location, pages).filter(it => it != none)

  [
    #authors. #year. #strong[#title]. #emph[#venue].
    #if publication-info.len() > 0 [
      #publication-info.join([, ]).
    ]
    #if links.len() > 0 [
      \
      #links.join([ · ])
    ]
  ]
}

#let page = (
  title: "Publications",
  description: "Academic and technical writings.",
  body: [
    + #publication(
      [An Example Publication Title],
      [Alice Example, *Yikun Wang*, and Bob Example],
      2026,
      [Proceedings of the Conference on Examples],
      links: (
        link("https://doi.org/00.0000/0000000.0000000")[DOI],
        link("https://example.com/paper.pdf")[PDF],
        link("https://example.com/code")[Code],
      ),
    )
  ],
)

#title(page.title)
#page.body
