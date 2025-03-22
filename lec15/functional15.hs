--course registration code is wrong
--  find a bug (give a test case), and give a fix

type CourseID = Int
type Capacity = Int
type StudentID = Int
data CourseInfo' = Course'
  { cid :: CourseID
  , cap :: Capacity
  , roster :: [StudentID]
  } deriving (Show)

enroll'' :: CourseInfo' -> StudentID ->
        Either String CourseInfo'
enroll'' c sid
  | sid `elem` rs =
      Left "student already registered"
  | length rs >= seats =
      Left "course full"
  | otherwise = Right $
      Course' (cid c) seats (sid:rs)
  where seats = cap c
        rs = roster c


register'' :: [CourseInfo']
    -> CourseID -> StudentID
    -> Either String [CourseInfo']
register'' [] _ _ = Left "no such course"
register'' (c : cs) cid' sid
  | cid c == cid' =
      case enroll'' c sid of
        Left msg -> Left msg
        Right c' -> Right (c' : cs)
  | otherwise = register'' cs cid' sid
-------------------Answer---------------------------
-- test case
--register'' reg 261409 (-600610799)
--กรณ๊เลขรหัสนักศึกษาติดลบ ถือว่าเป็นการทำรหัสนักศึกษาผิด format
-- edit version fix test case
register''' :: [CourseInfo']
    -> CourseID -> StudentID
    -> Either String [CourseInfo']
register''' courses cid' sid
  | sid <= 0 = Left "student id is incorrect format" 
  | otherwise = go courses
  where
    go [] = Left "no such course"
    go (c : cs)
      | cid c == cid' =
          case enroll'' c sid of
            Left msg -> Left msg
            Right c' -> Right (c' : cs)
      | otherwise =
          case go cs of
            Left msg -> Left msg
            Right updatedCourses -> Right (c : updatedCourses)

--for test
reg = [Course' 261216 100 [600610717],
  Course' 261218 90
      [600610738, 600610747],
  Course' 261409 70
      [600610754,
       600610777,
       600610783],
  Course' 261406 2
      [600610752, 600610764]]


--define function 
maybeAp ::Maybe (a -> b) -> Maybe a -> Maybe b
maybeAp Nothing _ = Nothing
maybeAp _ Nothing = Nothing
maybeAp (Just f) (Just x) = Just (f x)

--define function initMaybe
initMaybe :: a -> Maybe a
initMaybe x = Just x

--define function listAp 
listAp ::[a -> b] -> [a] -> [b]
listAp fs xs = [f x | f <- fs, x <- xs]

--define function initList :: a -> [a]
initList :: a -> [a]
initList x = x:[]

--explain what fmap (*3) (+100) is
--เป็น functor ที่จะรอจนกว่าจะได้รับค่า number จากนั้นจะ map เข้ากับ function(+100)และนำค่าทื่ได้ไป map เข้ากับ function (*3)