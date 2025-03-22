func1 :: (a -> b -> c) -> (a -> b) -> a -> c
func1 f g x = f x (g x)
--ถ้า f มี type เป็น (a -> b -> c) เมื่อรับ a -> b มาจะให้คำตอบ type c
--ถ้า g มี type เป็น (a -> b) เมื่อรับค่าที่เป็น type a มา จะได้คำตอบ type b
--เมื่อ x เป็น type a นำไปเข้า functtion g จะได้ type b ออกมา
--จากนั้นนำ x ซึ่งเป็น type a และ(g x) ซึ่งได้คำตอบออกมาเป็ฯ type b จะทำให้ f รับค่าที่มี type เป็น a -> b จะได้คำตอบสุดท้ายออกมาเป็น type c 

func2 :: (a, b) -> Either a b
func2 (x, _) = Left x
--รับค่าของ (,) ที่มี type เป็น a และ b ตามลำดับมาต้องการคำตอบเป็น type a หรือ b 
--ดังนั้นจากการที่รับ x มาซึ่งเป็ฯ type a และให้คำตอบเป็น left x ซึ่งเป็น type a
--ถ้า รับ (a,b) มาจริงจะให้ผลลัพธ์ เป็น type left a เสมอซึ่งเป็น Either a b

func3 :: (a -> b, a) -> b
func3 (f, x) = f x
--รับค่าของ (,) โดยมี type เป็น function a -> b และ a ตามลำดับ เมื่อนำ x ที่มี type เป็น a มาใส่ใน function f ซึ่งมี type เป็น a -> b
--หมาความว่าเมื่อ function f รับ ค่าที่มี type a มาจะได้คำตอบออกมาเป็น type b 

newtype Void = Void Void
absurd :: Void -> a
absurd (Void x) = absurd x

func4 :: Either (a -> Void) b -> a -> b
func4 (Right y) _ = y
func4 (Left f) x = absurd (f x)
--กรณี 1 เมื่อรับค่า Right y ซึ่งเป็น Either (a -> Void) b มา และให้คำตอบเป็น y เสมอซึ่งเป็น type b
--กรณี 2 เมื่อรับค่า Left f มา ซึ่ง f เป็น function ที่เปลี่ยนค่า x type a เป็น void 
--จากนั้นใช้ absurd ซึ่งสามารถรับค่า type void และเปลี่ยนเป็น type อื่นได้ ซึ่งในที่นี้คือ type b 