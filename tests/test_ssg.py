import tempfile
import unittest
from pathlib import Path

from ssg import SiteError, discover, generate_entry, relative_href


class DiscoveryTests(unittest.TestCase):
    def test_discovers_tree_and_routes(self):
        with tempfile.TemporaryDirectory() as directory:
            content = Path(directory)
            (content / "index.typ").write_text("#let page = (:)")
            (content / "research" / "systems").mkdir(parents=True)
            (content / "research" / "index.typ").write_text("#let page = (:)")
            (content / "research" / "systems" / "index.typ").write_text("#let page = (:)")

            root, nodes = discover(content)

            self.assertEqual([node.route for node in nodes], ["/", "/research/", "/research/systems/"])
            self.assertEqual(root.children[0].route, "/research/")
            self.assertEqual(relative_href(nodes[2], root), "../../")
            self.assertEqual(relative_href(root, nodes[2]), "research/systems/")

    def test_requires_parent_nodes(self):
        with tempfile.TemporaryDirectory() as directory:
            content = Path(directory)
            (content / "index.typ").write_text("#let page = (:)")
            (content / "missing" / "child").mkdir(parents=True)
            (content / "missing" / "child" / "index.typ").write_text("#let page = (:)")

            with self.assertRaises(SiteError):
                discover(content)

    def test_generated_entry_contains_tree_and_relative_links(self):
        with tempfile.TemporaryDirectory() as directory:
            project = Path(directory)
            content = project / "content"
            theme = project / "theme" / "render.typ"
            (content / "research").mkdir(parents=True)
            theme.parent.mkdir()
            theme.write_text("#let render(page, node, site) = page.body")
            (content / "index.typ").write_text('#let page = (title: "Home", body: [])')
            (content / "research" / "index.typ").write_text(
                '#let page = (title: "Research", body: [])'
            )

            root, nodes = discover(content)
            entry = generate_entry(project, theme, root, nodes)

            self.assertIn('#document("research/index.html"', entry)
            self.assertIn('#import "/theme/style.typ": emit-theme-assets', entry)
            self.assertIn("#emit-theme-assets()", entry)
            self.assertIn('root-prefix: "../"', entry)
            self.assertIn('page_0: "../"', entry)
            self.assertNotIn("updated-display:", entry)
            self.assertNotIn("  output:", entry)


if __name__ == "__main__":
    unittest.main()
