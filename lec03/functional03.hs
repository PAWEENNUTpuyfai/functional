
--zipper'
zipper' :: [a] -> [b] -> [(a, b)]
zipper' ([]) _ = []
zipper' (_) [] = []
zipper'(x:xs) (y:ys) = (x,y) : zipper' xs ys
--what's the type of zipper'?
--  zipper' :: [a] -> [b] -> [(a, b)]
--what's the type of zipper' []?
--  zipper' [] :: [b] -> [(a, b)]
--what does zipper' [] do?
--  เป็น function ที่รับค่า [] มาแล้วได้ผลลัพธ์เป็น function ที่รอรับค่า list แล้วได้ผลลัพธ์ออกมาเป็น [] เสมอ
--is there a simpler way to express the same thing?
--  คิดว่าน่าจะมีโดยสามารถเขียนว่าเมื่อรับ [] แล้วจะให้คำตอบเป็น [] เลยอาจจะทำให้บรรทัด 3 4 มารวมกันได้(มั้ง)


--factorail
fac :: (Eq t, Num t) => t -> t
fac 0 = 1
fac n = n * fac(n -1)
--what's the type of fac?
--  fac :: (Eq t, Num t) => t -> t
--is your implementation of fac safe?
--  No
--if not, when is it not safe, and what should you do to make it safer?
--  ไม่มีความปลอดภัยเนื่องจากว่าเมื่อรับค่า เลขติดลบจะทำให้เกิด error และเมื่อรับค่าเลขทศนิยม จะทำให้เกิด stack overflow
--  คิดว่าน่าจะสามารถกำหนดบังคับให้มีการใส่ได้แค่ค่าจำนวนเต็ม + และ 0 โดยอาจจะมีการขึ้นบอกเมื่อนมีการกรอกค่าผิดได้ว่าถ้าไม่ใช่ให้แจ้งไปยังผู้ใช้





