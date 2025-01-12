data Tree a =
      Empty
    | Node (Tree a) a (Tree a)
  deriving (Show,Eq)

insert :: Ord a => Tree a -> a -> Tree a
insert Empty x = Node Empty x Empty
insert (Node l v r) x
  | x < v     = Node (insert l x) v r
  | otherwise = Node l v (insert r x)

t = Node (Node (Node Empty 4 Empty) 9 (Node Empty 7 Empty)) 11 (Node (Node Empty 13 Empty) 15 (Node Empty 19 Empty))
--              11
--            /    \
--           9      15
--          /  \    / \
--         4    7  13  19

tree = foldl insert Empty [10, 5, 15, 3, 7, 12, 18]

--              10
--            /    \
--           5      15
--          /  \    / \
--         3    7  12  18


map_tree :: (t -> a) -> Tree t -> Tree a
map_tree _ Empty = Empty
map_tree f (Node l x r) = Node (map_tree f l) (f(x)) (map_tree f r)
--what's the type?
--  map_tree :: (t -> a) -> Tree t -> Tree a

fold_tree_1 :: (t1 -> t2 -> t1) -> t1 -> Tree t2 -> t1
fold_tree_1 _ acc Empty = acc
fold_tree_1 f acc (Node l x r) =  (fold_tree_1 f (fold_tree_1 f (f acc x) r) l )
--what's the type?
--  fold_tree_1 :: (t1 -> t2 -> t1) -> t1 -> Tree t2 -> t1
fold_tree_2 :: (p -> t2 -> p) -> p -> Tree t2 -> p
fold_tree_2 _ acc Empty = acc
fold_tree_2 f acc (Node l x r) =  (fold_tree_1 f (fold_tree_1 f (f acc x) l) r )
--what's the type?
--  fold_tree_2 :: (p -> t2 -> p) -> p -> Tree t2 -> p
--how many different folds can you come up with?
-- 2

tree_list :: Tree a -> [a]
tree_list Empty = []
tree_list (Node l x r) = tree_list(l) ++ [x] ++ tree_list(r)

lessthan :: (Foldable t, Ord a) => t a -> a -> Bool
lessthan l r = foldl (\acc x -> r > x && acc) True l  

gatherthan :: (Foldable t, Ord a) => t a -> a -> Bool
gatherthan l r = foldl (\acc x -> r <= x && acc) True l  

isBST :: Ord a => Tree a -> Bool
isBST Empty = True
isBST (Node l x r) = lessthan (tree_list l) x &&
                    gatherthan (tree_list r) x &&
                    isBST l && isBST r
--what's the type?
--  isBST :: Ord a => Tree a -> Bool

--define type NAryTree for n-ary trees, and implement preorder and postorder traversals
data NAryTree a =
      EmptyTree
    | Node_n a [NAryTree a]
  deriving (Show,Eq)

preorderNAry :: NAryTree a -> [a]
preorderNAry EmptyTree = []
preorderNAry (Node_n r l) =[r] ++ (foldr (\x acc -> preorderNAry(x) ++ acc ) [] l)

postorderNAry :: NAryTree a -> [a]
postorderNAry EmptyTree = []
postorderNAry (Node_n r l) = (foldr (\x acc -> postorderNAry(x) ++ acc ) [r] l)

nary = Node_n 1 [Node_n 2 [Node_n 4 [Node_n 9 []], Node_n 5 []], Node_n 3 [Node_n 6 [], Node_n 7 [], Node_n 8 []]]
--               1
--            /    \
--           2        3
--          /  \    / | \
--         4    5  6  7  8
--        /
--       9