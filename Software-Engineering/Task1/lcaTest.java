import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class lcaTest {

	@Test
	void test_basic() {
		lca tree = new lca(); 
        tree.root = new Node(1); 
        tree.root.left = new Node(2); 
        tree.root.right = new Node(3); 
        tree.root.left.left = new Node(4); 
        tree.root.left.right = new Node(5); 
        tree.root.right.left = new Node(6); 
        tree.root.right.right = new Node(7); 
        
        assert(tree.findLCA(4,5) == 2);
	}

	 @Test
	void test_null() {
		lca tree = new lca();
		tree.root = null;
		 
		 assert(tree.findLCA(5,6) == -1);
	}
	
	@Test
	void test_lowest_ancestor() {
		lca tree = new lca();
		tree.root = new Node(3); 
	    tree.root.left = new Node(5); 
	    tree.root.right = new Node(1); 
	    tree.root.left.left = new Node(6); 
	    tree.root.left.right = new Node(2); 
	    tree.root.right.left = new Node(0); 
	    tree.root.right.right = new Node(8);
	    tree.root.left.right.left = new Node(7);
	    tree.root.left.right.right = new Node(4);
	    
	    assert(tree.findLCA(5,4) == 5);
	}
	
}
