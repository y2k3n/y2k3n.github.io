#let page = (
  title: "CV",
  description: "Curriculum Vitae.",
  body: [
    #html.elem(
      "object",
      attrs: (
        data: "cv.pdf",
        type: "application/pdf",
        style: "width: 100%; height: 90vh; border: 0;",
      ),
    )[
      Your browser cannot preview this PDF.
      #link("cv.pdf")[Open or download] the CV.
    ]
  ],
)

#title(page.title)
#page.body
