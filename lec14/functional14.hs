--suppose we want to define a data type that counts the number of transformations done to the data:
data COp a = CVal Int a
    deriving (Show)
--is this an appropriate definition of a functor for COp?
instance Functor COp where
  fmap f (CVal c v)
      = CVal (c+1) (f v)
--Ans
--ไม่เนื่องจาก เราต้องการให้ CVal มีการนับจำนวนครั้งของการที่ค่ามีการเปลี่ยนแปลง
--แต่จากการเขียน functor นี้ทำให้การเรียกใช้ id ค่า count ก็จะมีการนับขึ้นทั้งๆที่ไม่มีการเปลี่ยนแปลงค่า


--define a functor for (->) r:
instance Functor ((->) r) where
    fmap f g r = f (g r)