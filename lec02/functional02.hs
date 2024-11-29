--zipper
zipper :: ([a], [b]) -> [(a, b)]
zipper([],list) = []
zipper(list,[]) = []
zipper(x:xs,y:ys) = (x,y) : (zipper(xs,ys))

--rev
rev :: [a] -> [a]
rev([]) = []
rev(x:xs) =  rev(xs) ++ [x]