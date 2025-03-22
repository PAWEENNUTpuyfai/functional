--show that (,) is a bifunctor by implementing
pairBimap :: (a -> c) -> (b -> d) -> (a, b) -> (c, d)
pairBimap f g (x, y) = (f x, g y)

{-
prove that these bifunctor laws hold:
pairBimap id id = id
---------------------------------------
pairBimap id id (x, y)  = (id x, id y)  
                        = (x, y)        
                        = id (x, y)    
---------------------------------------
pairBimap (f . g) (h . i) = pairBimap f h . pairBimap g i
---------------------------------------
pairBimap (f . g) (h . i) (x, y) = (f . g) x, (h . i) y
                                 = (f (g x), h (i y))
                                 = pairBimap f h (g x, i y)
                                 = pairBimap f h . pairBimap g i (x, y) 
---------------------------------------
-}
--write the following natural transformations
--Maybe → list
maybeToList :: Maybe a -> [a]
maybeToList Nothing = []   
maybeToList (Just x) = [x]
{-true or false, and why: for any f :: a -> b,
fmap f . maybeToList = maybeToList . fmap f
-----------------------------------------------
fmap f . maybeToList Nothing = fmap f maybeToList Nothing
                             = fmap f []
                             = []
(maybeToList . fmap f) Nothing  = maybeToList (fmap f Nothing)
                                = maybeToList Nothing
                                = []    ✔
-----------------------------------------------
fmap f . maybeToList (Just x) = fmap f (maybeToList (Just x))
                              = fmap f [x]
                              = [f x]
(maybeToList . fmap f) (Just x) = maybeToList (fmap f (Just x))
                                = maybeToList (Just (f x))
                                = [f x]  ✔
-}
--list → Maybe
listToMaybe :: [a] -> Maybe a
listToMaybe [] = Nothing
listToMaybe (x:_) = Just x
{-true or false, and why: for any f :: a -> b,
fmap f . listToMaybe = listToMaybe . fmap f
-----------------------------------------------
fmap f . listToMaybe [] = fmap f (listToMaybe [])
                        = fmap f Nothing
                        = Nothing
(listToMaybe . fmap f) [] = listToMaybe (fmap f [])
                          = listToMaybe []
                          = Nothing  ✔
-----------------------------------------------
fmap f . listToMaybe (x:xs) = fmap f (listToMaybe (x:xs))
                            = fmap f (Just x)
                            = Just (f x)
(listToMaybe . fmap f) (x:xs) = listToMaybe (fmap f (x:xs))
                              = listToMaybe (Just (f x))
                              = Just (f x)  ✔
-}
