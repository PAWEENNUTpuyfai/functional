newtype State s a =
    State { runState :: s -> (a, s) }

instance Functor (State s) where
    fmap :: (a -> b)
      -> State s a -> State s b
    fmap f (State g) = State $ \s ->
        let (x, s') = g s
        in (f x, s')

instance Applicative (State s) where
    pure :: a -> State s a
    pure x = State $ \s -> (x, s)

    (<*>) :: State s (a -> b) -> State s a
      -> State s b
    State h <*> State g = State $ \s ->
        let (f, s')   = h s
            (x', s'') = g s'
        in (f x', s'')

instance Monad (State s) where
    (>>=) :: State s a -> (a -> State s b)
      -> State s b
    State h >>= f = State $ \s ->
        let (x, s') = h s
            State g = f x
        in g s'
        
type Stack = [Int]

pop' :: State Stack Int
pop' = State $ \(x:xs) -> (x, xs)
push' :: Int -> State Stack ()
push' a = State $ \xs -> ((), a:xs)