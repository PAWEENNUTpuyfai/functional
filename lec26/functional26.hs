--implement the following functions using only these combinators from the SKI combinator calculus:
s :: (t1 -> t2 -> t3) -> (t1 -> t2) -> t1 -> t3
s x y z = x z (y z)

k :: p1 -> p2 -> p1
k x y = x

i :: p -> p
i x = x
--example: 
f :: a -> b -> b
f = k i
--  f x y = K I x y = I y = y
(.) :: (b->c) -> (a->b) -> (a->c)
(.) = s (k s) k
{-
    (.) f g x   = s (k s) k f g x
                = ((k s) f) (k f) g x
                = (k s f) f g x
                = (s) f g x
                = f x (g x) 

        
-}
(&) :: a -> (a->b) -> b
(&) = s (k (s i)) (s (k k) i)
{-
    (&) x g = s (k (s i)) (s (k k) i) x g
            = (k (s i)) x ((s (k k) i) x) g
            = s i ((s (k k) i) x) g
            = i g (((s (k k) i) x) g)
            = g (s (k k) i x g)
            = g (k k) x (i x) g
            = g k (i x) g
            = g (i x)
            = g x
-}
flip :: (a -> b -> c) -> b -> a -> c
flip = s (k (s (s i)) k) 
{-
    flip g x y  = s (k (s (s i)) k) g x y
                = (k (s (s i)) k) x (g x) y
                = (s (s i)) x (g x) y
                = (s i) (g x) (x (g x)) y
                = i(x (g x)) ((g x)(x (g x))) y
                = (x (g x)) ((g x)(x (g x))) y
                .
                .
                .
                .
                = g ((k i) x y) (k x y) ??????? how make this????
-}
