#let page = (
  title: "Notes on the Analytical Engine",
  description: "An example publication represented by an ordinary content node.",
  body: [
    *Ada Lovelace.* Example Proceedings, 1843.

    = Abstract

    This sample page demonstrates that a publication uses exactly the same
    representation and renderer as every other page.

    #link("supplement.txt")[Download the local supplement].
  ],
)

#title(page.title)
#page.body
