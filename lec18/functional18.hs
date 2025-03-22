--implement these functions
maybeJoin :: Maybe (Maybe a) -> Maybe a
maybeJoin = (>>= id)

listJoin :: [[a]] -> [a]
listJoin = (>>= id)

eitherJoin :: Either r (Either r a) -> Either r a
eitherJoin = (>>= id)

arrowJoin :: (r -> r -> a) -> r -> a
arrowJoin = (>>= id)

pairJoin :: (Monoid r) => (r, (r, a)) -> (r, a)
pairJoin = (>>= id)
--what do we need to know about r?
-- r ต้องเป็น monoid
--ซึ่งจำเป็นต้องเป็นไปตาามกฎคือต้องมี identity และมี associativity ของ operation (<>)

{-
prove that the three monad laws hold for the Either monad
hint: prove by cases (Left vs Right)
instance Monad (Either e) where
    	Right m >>= k = k m
    	Left e  >>= _ = Left e

1.first monad law (left identity): return a >>= k = k a
2.the second monad law (right identity): m >>= return = m
3.the third monad law (associativity): m >>= (\x -> k x >>= h) = (m >>= k) >>= h

--------------------Answer--------------------
-----1 law
(Right a)
return a >>= k
= Right a >>= k
= k a  ✔
return right เสมอเมื่อ return a
-----2 law
(Right a)
Right a >>= return
= return a
= Right a ✔
(left e)
Left e >>= return = Left e ✔
-----3 law
(Right a)
Right a >>= (\x -> k x >>= h)
= k a >>= h
= (return a >>= k) >>= h
				-- by first monad law
= (Right a >>= k) >>= h ✔
(left e)
Left e >>= (\x -> k x >>= h)
= Left e
= Left e >>= h
= (Left e >>= k) >>= h ✔
-}

{-
prove that the three monad laws hold for the list monad
instance Monad []  where
	xs >>= f = [y | x <- xs, y <- f x]
---------------------Answer----------------
for list
-----1 law
return a >>= k
= [a] >>= k
= [y | x <- [a], y <- k x]  
= [y | y <- k a]            
= k a ✔
-----2 law
[] >>= return
= [y | x <- [], y <- return x] 
= [] ✔
(xs non empty list)
xs >>= return
= [y | x <- xs, y <- return x]
= [y | x <- xs, y <- [x]]
= [xs] ✔
-----3 law
([] empty list)
[] >>= (\x -> k x >>= h)
= [y | x <- [], y <- (k x >>= h)]
= []   ✔
(xs non empty list)
xs >>= (\x -> k x >>= h)
= [y | x <- xs, y <- (k x >>= h)]
= [y | x <- xs, y <- [z | w <- k x, z <- h w]]
= [z | x <- xs, w <- k x, z <- h w]  ✔
-}

{-
prove that the three monad laws hold for the arrow monad
hint: unlock each side of the equality with a value of type r, and check that both sides are indeed equal
instance Monad ((->) r) where
	f >>= k = \ r -> k (f r) r
------------------Answer--------------
------1 law
return a >>= k
= (\ r -> a) >>= k
= \ r -> k (a) r
= k a ✔
------2 law
f >>= return
= \ r -> return (f r) r
= \ r -> (\ r' -> f r) r
= f r ✔
------3 law
f >>= (\ x -> k x >>= h)
= \ r -> (\ x -> k x >>= h) (f r) r
= \ r -> k (f r) >>= h r
= \ r -> h (k (f r) r) r ✔
-}
