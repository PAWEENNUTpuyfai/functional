-- list.hs size of list
len :: Num a1 => [a2] -> a1
len[] = 0
len(x:xs) = 1 + len xs

-- join
join :: ([a], [a]) -> [a]
join([],y) = y
join(x:xs,y) = x:join(xs,y)

join'[] ys = ys
join'(x:xs) ys = x:join' xs ys
