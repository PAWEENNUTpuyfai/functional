{-
Q1 give three more examples of monoids
the carrier sets must be different from the examples and from each other
be sure to reason about monoid laws
LAW
1.Identity
x <> mempty = x (right identity)
mempty <> 𝑥 = 𝑥 (left identity) 
2.associativity x <> (y <> z) = (x <> y) <> z
--------------Answer--------------
1.carrier: set of negative integers
operator(min)
-identity ของ min คือ -1 min ของ x ใดๆ กับ -1 จะได้ x เสมอ
-min(x,min(y,z)) = min(min(x,y),z) จะได้ ค่าเดิมเสมอแม้ว่าลำดับจะเปลี่ยน

2.Carrier: Set of Sets
Operator: intersection (Set Intersection)
-Identity ของ intersection คือ Universal Set (U) เพราะ x intersection U = x เสมอ
-x intersection (y intersection z) = (x intersection y) intersection z  จะได้ค่าเดิมเสมอแม้ว่าลำดับจะเปลี่ยน

3. Carrier: (a -> a)
Operator: (.) (Function Composition)
-Identity ของ Function Composition คือ id 
f . id = f    Right identity
id . f = f    Left identity
-(f . g) . h = f . (g . h) จะได้ ค่าเดิมเสมอแม้ว่าลำดับจะเปลี่ยน
 -}

{-
Q2 using newtype, declare monoid instances for Bool, where
operator: (&&)
operator: (||)
-}

newtype And = And {getAnd :: Bool} deriving (Show)
instance Semigroup And where
    And x <> And y = And (x && y)

instance Monoid And where
    mempty = And True

newtype Or = Or {getOr :: Bool} deriving (Show)
instance Semigroup Or where
    Or x <> Or y = Or (x || y)

instance Monoid Or where
    mempty = Or False

--define function maybeBind :: Maybe a -> (a -> Maybe b) -> Maybe b
maybeBind :: Maybe a -> (a -> Maybe b) -> Maybe b
maybeBind Nothing _ = Nothing
maybeBind (Just x) f = f x

--define function listBind :: [a] -> (a -> [b]) -> [b]
listBind :: [a] -> (a -> [b]) -> [b]
listBind [] _ = []
listBind (x:xs) f = f x ++ listBind xs f

--define function eitherBind :: Either r a -> (a -> Either r b) -> Either r b
eitherBind :: Either r a -> (a -> Either r b) -> Either r b
eitherBind (Left r) _ = Left r
eitherBind (Right x) f = f x

--define function arrowBind :: (r -> a) -> (a -> (r -> b)) -> (r -> b)
arrowBind :: (r -> a) -> (a -> (r -> b)) -> (r -> b)
arrowBind f g = \r -> g (f r) r

--define function pairBind :: (r, a) -> (a -> (r, b)) -> (r, b)
pairBind :: (Monoid r) => (r, a) -> (a -> (r, b)) -> (r, b)
pairBind (r, x) f = (r <> r', y)
  where
    (r', y) = f x
--what do we need to know about r?
-- r ต้องเป็น monoid
--ซึ่งจำเป็ฯต้องเป็ฯไปตาามกฎคือต้องมี identity และมี associativity ของ operation (<>)
