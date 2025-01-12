--write this function in point-free style:
contains1 :: (Foldable t, Ord a) => a -> t a -> Bool
contains1 = \x l -> any (x<) l
con1 :: (Foldable t, Ord a) => a -> t a -> Bool
con1 =  (any) . (<)

--write this function in point-free style:
contains2 :: (Foldable t, Ord a) => t a -> a -> Bool
contains2 = \l x -> any (x<) l
con2 :: (Foldable t, Ord a) => t a -> a -> Bool
con2 =flip ((any) . (<))

--write function len_comp that uses list comprehension to compute the length of the given list
len_comp :: Num a => [t] -> a
len_comp l = sum[1 | x <- l]

-- rewrite [(x,y) | x <- [2,3,5], y <- [1,2,4], even $ x+y] without using list comprehension
res = filter (even . uncurry (+)) $ concat $ map (\x -> map (x,) [1, 2, 4]) [2, 3, 5]

