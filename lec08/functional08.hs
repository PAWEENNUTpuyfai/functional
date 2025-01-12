partition :: (a -> Bool) -> [a] -> ([a], [a])
partition p [] = ([], [])
partition p (x:xs)
  | p x       = (x:l, r)
  | otherwise = (l, x:r)
  where (l, r) = partition p xs
  
--what's the type of partition?
--  partition :: (a -> Bool) -> [a] -> ([a], [a])
--what does partition do?
--แบ่ง list ออกเป็น 2 list โดยขึ้นอยู่กับเงื่อนไข p ถ้าตรงเงื่อนไข จะเป็น list แรก(list l),ถ้าไม่ตรงเงื่อนไขจะเป็น list หลัง(list r)

--rewrite filter using partition
filter' :: (a -> Bool) -> [a] -> [a]
filter' p [] = []
filter' p (x:xs)
  | p x       = (x:l)
  | otherwise = (l)
  where (l) = filter' p xs



filter'' p [] = []
filter'' p (x:xs) = fst (partition p (x:xs))

--rewrite quicksort without using list comprehension
qsort []      = []
qsort (hd:tl) =
    qsort l ++ [hd] ++ qsort r
  where l = filter'(hd>) tl
        r = filter'(hd<=) tl

--look up type Ordering
--  what is it for?
--    ใช้สำหรับการเปรีบเทียบ น้อยกว่า เท่ากับ มากกว่า
--  how many constructors are there?
--    3 LT EQ GT
--  how many ways can we pattern-match an Ordering value?
--    3 

g :: Fractional a => [String] -> [a]
g [] = []
g (x:xs)  
  | ("A" == x ) = ((4.0) : l)
  | ("B+" == x) = ((3.5) : l)
  | ("B" == x)  = ((3.0) : l)
  | ("C+" == x) = ((2.5) : l)
  | ("C" == x)  = ((2.0) : l)
  | ("D+" == x) = ((1.5) : l)
  | ("D" == x)  = ((1.0) : l)
  | ("F" == x)  = ((0.0) : l)
  | ("W" == x)  = l
   | otherwise = error "undefine grade"
  where (l) = g xs

--write function gpa that computes grade-point average from a given list of letter grades
gpa :: Fractional a => [String] -> a
gpa [] = 0
gpa (l) = sum [ x | x <-(g (l))]  / fromIntegral(length(g (l))) 
--what's the type of gpa?
--  gpa :: Fractional a => [String] -> a
