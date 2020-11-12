from LCAProgDag import Node, dagLCA
import unittest

class LCAProgDagTest:
    def test_basic(self):
        root = Node(1)
        r2 = Node(2)
        r3 = Node(3)
        r4 = Node(4)
        r5 = Node(5)
        r6 = Node(6)
        root.succ = [r2,r3,r4,r5]
        r2.succ = [r4]
        r2.pre = [root]
        r3.succ = [r4, r5]
        r3.pre = [root]
        r4.succ = [r5]
        r4.pre = [r2,r3,root]
        r5.pre = [r3,r4,root]
        r6.pre = [r4]

        lca = dagLCA(root, r4, r5)

        assert lca is 3

    def test_null(self):
        root = None

        lca = dagLCA(root, 4, 5)

        assert lca is None

    def test_root(self):
        root = Node(1)
        r2 = Node(2)
        r3 = Node(3)
        root.succ = [r2,r3]

        lca = dagLCA(root, root, r3)
        assert lca is 1
        lca = dagLCA(root, r3, root)
        assert lca is 1
        lca = dagLCA(root, r2, r2)
        assert lca is 2
