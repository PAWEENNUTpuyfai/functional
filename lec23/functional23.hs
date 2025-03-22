import Text.Read
import System.Random 
-------reader monad----------
newtype Reader r a = Reader {
  runReader :: r -> a
}
ask :: Reader r r
ask = Reader id
instance Functor (Reader r) where
  fmap :: (a -> b) -> Reader r a -> Reader r b
  fmap f (Reader rf) = Reader $ f . rf

instance Applicative (Reader r) where
  pure :: a -> Reader r a
  pure x = Reader $ const x
  (<*>) :: Reader r (a -> b) -> Reader r a -> Reader r b
  (Reader rf) <*> (Reader rx) = Reader $ rf <*> rx

instance Monad (Reader r) where
  (>>=) :: Reader r a -> (a -> Reader r b) -> Reader r b
  (Reader ra) >>= f = Reader $ \r -> runReader (f (ra r)) r

------writer monad---------

newtype Writer w a = Writer {
  runWriter :: (a, w)
}
tell :: w -> Writer w ()
tell log = Writer ((), log)
instance Functor (Writer w) where
  fmap :: (a -> b) -> Writer w a -> Writer w b
  fmap f (Writer (a, w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
  pure :: a -> Writer w a
  pure x = Writer (x, mempty)
  (<*>) :: Writer w (a -> b) -> Writer w a -> Writer w b
  (Writer (f, wf)) <*> (Writer (x, wx)) = Writer (f x, wf <> wx)

instance Monoid w => Monad (Writer w) where
  (>>=) :: Writer w a -> (a -> Writer w b) -> Writer w b
  (Writer (a, wa)) >>= f = Writer (b, wa <> wb)	where Writer (b, wb) = f a


------callCnt--------
type GuessLog = [Int]

newtype CallCnt' =
  CallCnt' { runCallCnt :: Integer }
instance Semigroup CallCnt' where
  (CallCnt' a) <> (CallCnt' b) = CallCnt' (a + b)
instance Monoid CallCnt' where
  mempty = CallCnt' 0
instance Show CallCnt' where
  show (CallCnt' a) = show a


randNum :: RandomGen g => g -> Int
randNum gen = fst $ uniform gen

readNumber :: [Char] -> IO Int
readNumber msg = do
    putStr $ msg ++ ": "
    line <- getLine
    case readEither line :: Either String Int of
        Left e -> do
            putStrLn e
            readNumber msg
        Right n -> return n

verdict' :: Int -> Int -> (Maybe Int, Maybe Int) -> Either (String, (Maybe Int, Maybe Int)) String
verdict' target guess (lo, hi) = do
    case compare guess target of
        EQ -> Right "You win!"
        LT -> Left ("Too low", (Just guess, hi))
        GT -> Left ("Too high", (lo, Just guess))

getRange = do
    lo <- readNumber "Lower bound"
    hi <- readNumber "Upper bound"
    if lo > hi
    then do
        putStrLn "Invalid range"
        getRange
    else return (lo, hi)

inRange (lo, hi) guess =
    maybe True (<guess) lo
    && maybe True (>guess) hi

readGuess range = do
    guess <- readNumber "Guess"
    if inRange range guess
    then return guess
    else do
        putStrLn "Impossible answer"
        readGuess range


-- writeHistory _ _ _ history (Right msg) =
--     Writer (True, (CallCnt' 1, history))  
-- writeHistory num count range history (Left (msg, range')) =
--     Writer (False, (CallCnt' 1, history))  

-- runGameRg num range count cont history = do
--     guess <- readGuess range
--     let v = verdict' num guess range
--     putStrLn $ either fst id v  
--     let Writer (result, (CallCnt' _, newHistory)) = writeHistory num count range (history ++ [guess]) v
--     if result
--         then return (True, newHistory)  
--         else if cont (history ++ [guess])
--             then runGameRg num (either snd (const range) v) (count + 1) cont newHistory
--             else return (False, newHistory)  


-- v4 = do
--     g <- newStdGen
--     range <- getRange
--     lim <- readNumber "Guess limit"
--     let (num, _) = uniformR range g
--     (won, history) <- runGameRg num (Nothing, Nothing) 1 (\h -> length h < lim) []
--     putStrLn $ "History of guesses: " ++ show history

-- Writer-based game function with history and call count tracking

-- Writer-based game logic with history and call count tracking
writeHistory :: Int -> Int -> (Maybe Int, Maybe Int) -> GuessLog -> Either (String, (Maybe Int, Maybe Int)) String -> Writer CallCnt' (Bool, GuessLog)
writeHistory _ _ _ history (Right _) =
    tell (CallCnt' 1) >> return (True, history)  -- win case, record call and return true
writeHistory num count range history (Left (_, newRange)) =
    tell (CallCnt' 1) >> return (False, history)  -- continue playing, record call

-- Adjusted runGameReader function
runGameReader :: Int -> (Maybe Int, Maybe Int) -> Int -> Int -> GuessLog -> Reader (Int, Int) (Writer CallCnt' (Bool, GuessLog))
runGameReader target range count limit history
  | count > limit = return $ tell (CallCnt' 0) >> return (False, history)  -- Game over case
  | otherwise = do
      -- Fetch the current range configuration (lower and upper bounds)
      (lo, hi) <- ask
      let guess = head history  -- Get the last guess
      let result = verdict' target guess range
      case result of
          Right _ -> return $ tell (CallCnt' 1) >> return (True, history)  -- Win condition
          Left (msg, newRange) -> return $ tell (CallCnt' 1) >> runGameReader target newRange (count + 1) limit history

-- Adjusted playGame function with proper destructuring of result
playGame :: IO ()
playGame = do
    g <- newStdGen
    range <- getRange
    lim <- readNumber "Guess limit"
    let (target, _) = uniformR range g
    
    -- Start guessing loop using Reader and Writer monads
    let gameLoop :: GuessLog -> IO (Bool, GuessLog)
        gameLoop history = do
            guess <- readGuess (Nothing, Nothing)
            let resultWriter = runWriter (runReader (runGameReader target (Nothing, Nothing) 1 lim (guess : history)) range)
            let (result, history') = resultWriter  -- Destructure the result
            putStrLn $ either fst id (verdict' target guess (Nothing, Nothing))
            if result
                then return (True, history')
                else if length history' >= lim
                    then return (False, history')
                    else gameLoop history'

    (won, history) <- gameLoop []

    putStrLn $ if won then "You win!" else "Game over"
    putStrLn $ "History of guesses: " ++ show (reverse history)
