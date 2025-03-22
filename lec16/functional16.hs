--suppose we want to make (,) r an applicative functor
--that means we need to implement
--(<*>) ::
--  (r, a -> b) -> (r, a) -> (r, b)
--r could be any type, for representing labels
--but now we have two pieces of data containing labels (i.e., (r,a->b) and (r,a))
--how should we implement (<*>) so that the resulting data contain appropriate label?
----------------Answer----------------------
--  ในการ implement จะแบ่งมองออกเป็น 2 ส่วนได้แก่
--      ส่วนของ r จะต้องมีการรวม data type r เข้าด้วยกัน โดยต้องสามารถรวมข้อมูลได้ทุก type ไม่ว่าจะเป็น
--  number อาจจะโดยการใช้ผลบวกของ 2 ตัว list โดยกาารต่อ 2 อันเข้าด้วยกัน เช่นเดียวกับของ string 
--  โดยอาจจจะใช้การ implement แยกต่างหากสำหรับแต่ละ data type แต่ละกรณี 
--      ส่วนที่เหลือจะเป็นการ นำ a ซึ่งจะเป็น type ที่ต้องการเพื่อนำไปใช้ใน การหา b ออกมา
--  เพื่อนำมาเป็นคำตอบ โดยการหาค่าของ function data type a (f(x))และจะได้ b เป็นคำตอบ

--how should we implement pure so that the initial label makes sense?
--------------------Answer---------------------
--(,) r เป็น pair โดยมีตัวแรกเป็น type r และตัวหลังเป็น type ของค่าที่รับเข้ามา
--โดย r เป็น type อะไรก็ได้ 

instance Applicative (,)r where
    pure x = (r,x)


--prove that the four applicative functor laws hold for (->) r applicative functor
--hint: apply each side of the equality to an argument (of type r), and check that both sides are indeed equal
instance Applicative ((->) r) where
	pure = const
	(<*>) f g x = f x (g x)
----------------------Answer--------------------
--  1.Identity pure id <*> v = v
--  (pure id <*> v) x       ใส่ค่า x เพิ่มลงไป
--  = (const id v) x        
--  = id v x                const จะได้ค่าเดิม
--  = v x                   id คือค่านั้นซึ่งเท่ากันถูกต้องตามกฎนี้

--  2.composition pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
--  pure (.) <*> const x <*> const y <*> const z
--  = const (x . y) <*> const z     นำ const x มา apply กับ const y
--  = const ((x.y) z)               นำมา apply กับ  const z ต่อ
--  = const (x $ y z)               เปลี่ยนเป็นการทำ y z ก่อน 
--  = const x <*> const (y z)       แปลง apply กลับ
--  = const x <*> (const y <*> const z)

-- 3.homomorphism pure f <*> pure x = pure (f x)
-- pure f <*> pure <*> x
-- = const f <*> const x
-- = const (f x)            นำมา apply กัน
-- = pure (f x)

-- 4.interchange u <*> pure y = pure ($ y) <*> u
-- const x <*> pure y
-- = const x <*> const y
-- = const (x y)            apply
-- = const (x $ y)
-- = const (($ y) x)
-- = const ($ y) <*> const x
-- = pure ($ y) <*> const x