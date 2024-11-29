--reverse
rev l = aux l []
    where   
        aux [] res = res
        aux (x:xs) res = aux xs (x:res)

--list mapping
list_map :: (t -> a, [t]) -> [a]
--type
list_map ((f),[]) = []
list_map ((f),x:xs) = f(x) : list_map((f),xs) 
--list mapping' 
list_map' :: (t -> a) -> [t] -> [a]
--type
list_map' f [] = []
list_map' f (x:xs) = f(x) : list_map' f (xs) 

--list mapping tail recursion
list_map'' :: (t -> a) -> [t] -> [a]
list_map'' f l = rev(aux f l [])
    where   
        aux f [] res = res
        aux f (x:xs) res = aux f xs (f(x):res) 
--wirte three more test cases for list_map''
--  case 1
--      list_map'' (++"helloword") ["pui","mind","fah","tonnam"]
--      ["puihelloword","mindhelloword","fahhelloword","tonnamhelloword"]
--  case 2
--      list_map'' (*10) [12,41.5,1.2,145,3,1]                  
--      [120.0,415.0,12.0,1450.0,30.0,10.0]
--  case 3
--       list_map'' (> 2) [3,2,1,6,4,78]                         
--      [True,False,False,True,True,True]

--zipper
zipper :: [a] -> [b] -> [(a, b)]
zipper [] _ = []
zipper _ [] = []
zipper (x:xs) (y:ys) = (x,y) : zipper xs ys
--zipper tail recursion
zipper' :: [a] -> [b] -> [(a, b)]
zipper' list1 list2 = rev(aux list1 list2 [])
    where
        aux [] _ res = res
        aux _ [] res = res
        aux (x:xs) (y:ys) res = aux (xs) (ys)  ((x,y):res)

--challenge
fibs = 0 : 1 : zipWith (+) (tail(fibs))  fibs