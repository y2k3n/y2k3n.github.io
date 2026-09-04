#let nav-link(current, target) = {
  let label = if target.route == "/" { "Home" } else { target.page.title }
  if current.id == target.id {
    html.a(href: current.links.at(target.id), class: "active", label)
  } else {
    html.a(href: current.links.at(target.id), label)
  }
}

#let child-link(current, child) = html.li[
  #html.p[
    #html.a(href: current.links.at(child.id), child.page.title)
    #if "description" in child.page {
      [ — #child.page.description]
    }
  ]
]

#let render(page, node, site) = html.html(lang: "en", {
  let document-title = if node.id == site.id {
    page.title
  } else {
    page.title + " | " + site.page.title
  }

  html.head({
    html.meta(charset: "utf-8")
    html.meta(name: "viewport", content: "width=device-width, initial-scale=1")
    html.meta(name: "generator", content: "directory-typst-ssg")
    if "description" in page {
      html.meta(name: "description", content: page.description)
    }
    html.title(document-title)
    html.link(rel: "stylesheet", href: node.asset-prefix + "style.css")
  })

  html.body({
    html.header(class: "site-header", {
      html.div(class: if node.id == site.id {
        ("header-inner", "home-header")
      } else {
        "header-inner"
      }, {
        if node.id != site.id {
          html.a(class: "site-name", href: node.links.at(site.id), site.page.title)
        }
        html.nav(class: "site-nav", {
          let items = (site,) + site.children
          items.map(item => nav-link(node, item)).join()
        })
      })
    })

    html.main(class: "page-shell", {
      html.article(class: "page-content", {
        html.h1(page.title)
        page.body
      })

      if node.children.len() > 0 {
        html.section(class: "children", {
          html.h2("Pages")
          html.ul(
            node.children.map(child => child-link(node, child)).join(),
          )
        })
      }
    })

    html.footer(class: "site-footer", {
      html.p(class: "updated", {
        [Last updated ]
        html.elem("time", attrs: (datetime: node.updated), node.updated)
        [. ]
        [Typeset with ]
        html.a(href: "https://typst.app/", [Typst])
        [.]
      })
    })
  })
})
