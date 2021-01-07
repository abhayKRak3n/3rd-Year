{- butrfeld Andrew Butterfield -}
module Ex04 where

name, idno, username :: String
name      =  "Khanka, Abhay Singh"  -- replace with your name
idno      =  "18309999"    -- replace with your student id
username  =  "khankaa"   -- replace with your TCD username

declaration -- do not modify this
 = unlines
     [ ""
     , "@@@ This exercise is all my own work."
     , "@@@ Signed: " ++ name
     , "@@@ "++idno++" "++username
     ]

-- Datatypes -------------------------------------------------------------------

-- do not change anything in this section !


-- a binary tree datatype, honestly!
data BinTree k d
  = Branch (BinTree k d) (BinTree k d) k d
  | Leaf k d
  | Empty
  deriving (Eq, Show)


-- Part 1 : Tree Insert -------------------------------

-- Implement:
ins :: Ord k => k -> d -> BinTree k d -> BinTree k d
ins k d Empty = Leaf k d
ins k d (Leaf k2 d2)
    | k == k2 = Leaf k d 
    | k < k2  = Branch (Leaf k d) Empty k2 d2
    | k > k2  = Branch Empty (Leaf k d) k2 d2

ins k d (Branch left right k2 d2)
    | k == k2 = Branch left right k d 
    | k < k2  = Branch (ins k d left) right k2 d2
    | k > k2 = Branch left (ins k d right) k2 d2

-- Part 2 : Tree Lookup -------------------------------

-- Implement:
lkp :: (Monad m, Ord k) => BinTree k d -> k -> m d
lkp Empty k = fail ( "TREE IS EMPTY")
lkp (Leaf key value) k 
  | k == key = return value
  | otherwise = fail ( "KEY NOT FOUND" )
lkp (Branch left right key value) k
  | k < key  = lkp left k
  | k > key  = lkp right k
  | k == key = return value

-- Part 3 : Tail-Recursive Statistics

{-
   It is possible to compute BOTH average and standard deviation
   in one pass along a list of data items by summing both the data
   and the square of the data.
-}
twobirdsonestone :: Double -> Double -> Int -> (Double, Double)
twobirdsonestone listsum sumofsquares len
 = (average,sqrt variance)
 where
   nd = fromInteger $ toInteger len
   average = listsum / nd
   variance = sumofsquares / nd - average * average

{-
  The following function takes a list of numbers  (Double)
  and returns a triple containing
   the length of the list (Int)
   the sum of the numbers (Double)
   the sum of the squares of the numbers (Double)

   You will need to update the definitions of init1, init2 and init3 here.
-}
getLengthAndSums :: [Double] -> (Int,Double,Double)
getLengthAndSums ds = getLASs init1 init2 init3 ds
init1 = 0
init2 = 0.0
init3 = 0.0

{-
  Implement the following tail-recursive  helper function
-}
getLASs :: Int -> Double -> Double -> [Double] -> (Int,Double,Double)
getLASs a b c [] = (a,b,c)
getLASs a b c (x:xs) = do
    let init1 = a + 1
    let init2 = b + x 
    let init3 = c + x*x
    getLASs init1 init2 init3 xs
