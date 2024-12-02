--filter concat
filter_concat :: ([a] -> Bool) -> [[a]] -> [a]
filter_concat _ [] = []
filter_concat con (x:xs) = if con(x) 
                            then x ++ filter_concat con xs 
                            else filter_concat con xs 
--what's the type of filter_concat?
--  filter_concat :: ([a] -> Bool) -> [[a]] -> [a]
--can you avoid recursion in your definition?
--  (feel free to use functions from the Prelude)
--filter concat avoid recursion
filter_concat' :: ([a] -> Bool) -> [[a]] -> [a]
filter_concat' con l = concat (filter (con) (l))


--take while
take_while :: (a -> Bool) -> [a] -> [a]
take_while _ [] = []
take_while con (x:xs) = if con(x)
                        then x : take_while con xs
                        else []
                        
--what's the type of take_while?
--  take_while :: (a -> Bool) -> [a] -> [a]
--rewrite (\l -> length l < 3) without using lambda expressions
--  (( < 3 ) . length)
--what's the type of your answer?
--  (( < 3 ) . length) :: Foldable t => t a -> Bool