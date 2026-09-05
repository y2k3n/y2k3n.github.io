#let page = (
  title: "Yikun Wang",
  description: "A simple academic homepage generated from Typst pages.",
  body: [
    #html.div(style: "display: flex;")[
      #html.div(style: "width: 50%; font-size: 0.9rem; line-height: 1.44;")[
        _PhD Student \
        #link("https://cse.hkust.edu.hk/")[Department of Computer Science and Engineering] \
        #link("https://hkust.edu.hk/")[Hong Kong University of Science and Technology]_
      ]
      #html.div(style: "width: 50%; text-align: right;")[
        #link("mailto:ywangvz@cse.ust.hk")[#text("ywangvz@cse.ust.hk")] \
        #link(
          "https://github.com/y2k3n",
        )[GitHub] · #link(
          "https://orcid.org/0009-0009-5451-3550",
        )[ORCID]
      ]
    ]

    I am a 1#super[st] year PhD student advised by #link(
      "https://shenjiasi.com/",
    )[Prof. Jiasi Shen]. I am interested in Programming Languages and Software
    Engineering.

    // = About this site

    // Every page on this site is a #link("https://typst.app")[Typst] file.
    // Hierarchies and navigations are generated solely from the surrounding
    // directory structure. Check out the #link(
    //   "https://github.com/y2k3n/y2k3n.github.io",
    // )[repo].
  ],
)

#title(page.title)
#page.body
