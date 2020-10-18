import unittest
import LCAProg

LCAProg
class LCATest(unittest.TestCase):
    def test_basic(self):
        root = LCAProg.Node(1)
        root.left = LCAProg.Node(2)
        root.right = LCAProg.Node(3)
        root.left.left = LCAProg.Node(4)
        root.left.right = LCAProg.Node(5)
        root.right.left = LCAProg.Node(6)
        root.right.right = LCAProg.Node(7)

        lca = LCAProg.findLCA(root, 4, 5)

        assert lca is 2

    def test_null(self):
        root = None

        lca = LCAProg.findLCA(root, 4, 5)

        assert lca is -1

    def test_lowest_ancestor(self):
        root = LCAProg.Node(3)
        root.left = LCAProg.Node(5)
        root.right = LCAProg.Node(1)
        root.left.left = LCAProg.Node(6)
        root.left.right = LCAProg.Node(2)
        root.right.left = LCAProg.Node(0)
        root.right.right = LCAProg.Node(8)
        root.left.right.left = LCAProg.Node(7)
        root.left.right.right = LCAProg.Node(4)

        lca = LCAProg.findLCA(root, 5, 4)

        assert lca is 5


