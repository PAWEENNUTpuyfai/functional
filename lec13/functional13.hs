--many programming languages allow arbitrary expressions as conditions in the if statements:
--  if (cond) { ... } else { ... }
--we can capture this fact as a typeclass that interprets arbitrary expressions as a reasonable boolean value:
--class IfValue a where
--  boolVal :: a -> Bool
--any type that can be used as a condition should implement this typeclass
--  example:

class IfValue a where
    boolVal :: a -> Bool

instance IfValue Int where
    boolVal 0 = False
    boolVal _ = True

instance IfValue Double where
    boolVal 0.0 = False
    boolVal _ = True

instance IfValue Float where
    boolVal 0.0 = False
    boolVal _ = True

instance IfValue [a] where
    boolVal [] = False
    boolVal _ = True

instance IfValue Char where
    boolVal '0' = False
    boolVal _ = True

instance IfValue (Maybe a) where
    boolVal Nothing = False
    boolVal _ = True

--define map for Maybe type
map' :: (t -> a) -> Maybe t -> Maybe a
map' _ Nothing  = Nothing
map' f (Just a)   = Just (f a)

--define map for pairs, if you can

mapPair :: (a -> b) -> (a, a) -> (b, b)
mapPair f (x, y) = (f x, f y)

--------------------------------
mapPairs :: (a -> b) -> (a, a) -> (b, b)
mapPairs f (x, y) = (mapfst f (x, y), mapsnd f (x, y))

mapfst :: (a -> b) -> (a, a) -> b
mapfst f (x, _) = f x

mapsnd :: (a -> b) -> (a, a) -> b
mapsnd f (_, y) = f y