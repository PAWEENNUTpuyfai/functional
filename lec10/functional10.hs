--write function elem that determines whether a given element is a member of a list
my_elem :: Eq t => t -> [t] -> Bool
my_elem _ [] = False
my_elem x (l:ls) 
    | x == l    = True
    | otherwise = my_elem x (ls)  
--what's the type of elem?
--  my_elem :: Eq t => t -> [t] -> Bool
--can you use fold?
elem_fold :: (Foldable t, Eq a) => a -> t a -> Bool
elem_fold x l = foldl (\acc e-> if x == e then True else acc) False l

--rewrite partition using fold
partition_fold :: Foldable t => (a -> Bool) -> t a -> ([a], [a])
partition_fold p l = foldr (\x (accf,accs) -> if p(x) then (x:accf,accs) else (accf,x:accs) ) ([],[]) l

--challenge (extra credits):
--  define foldl in terms of foldr
reverse_right :: Foldable t => t a -> [a]
reverse_right l = foldr (\x acc -> acc ++ [x]) [] l

foldl' :: Foldable t => (a -> b -> a) -> a -> t b -> a
foldl' f acc l =foldr (\x acc-> flip(f) x acc) acc (reverse_right (l))

--define type Month whose values are months in a year
data Month = January | February | March | April | May | June | July |
     August | September | October | November | December deriving (Show)


daysInMonth :: Month -> Integer
daysInMonth m = case m of
    January     -> 31
    February    -> 28 
    March       -> 31
    April       -> 30
    May         -> 31
    June        -> 30
    July        -> 31
    August      -> 31
    September   -> 30
    October     -> 31
    November    -> 30
    December    -> 31
nextMonth :: Month -> Month
nextMonth m = case m of
    January     -> February 
    February    -> March    
    March       -> April    
    April       -> May      
    May         -> June     
    June        -> July     
    July        -> August   
    August      -> September
    September   -> October  
    October     -> November 
    November    -> December 
    December    -> January  

nextDay :: Integer -> Month -> (Integer, Month)
nextDay d m 
    | d == daysInMonth m  =  (1,nextMonth m)
    | otherwise            =   (d+1,m)




--test challenge
filterFoldl :: Foldable t => (a -> Bool) -> t a -> [a]
filterFoldl pred = foldl' (\acc x -> if pred x then acc ++ [x] else acc) []

mapFoldl :: Foldable t1 => (t2 -> a) -> t1 t2 -> [a]
mapFoldl f xs = reverse (foldl' (\acc x -> f x : acc) [] xs)

reverse_left :: Foldable t => t a -> [a]
reverse_left l = foldl' (flip (:)) [] l 
