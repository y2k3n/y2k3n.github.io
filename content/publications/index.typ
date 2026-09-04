#let page = (
  title: "Publications",
  description: "Selected papers and technical writing.",
  body: [
    Publications are ordinary child nodes. The generator has no special concept
    of papers, collections, years, or bibliographies.
    - First item
    - Second item
    - Third item
  ],
)

#title(page.title)
#page.body
