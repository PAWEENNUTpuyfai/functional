--how should we define equality for binary trees?
--  when are two binary trees equal?
-- เริ่มเช็คค่าจาก root โดยเช็คค่าด้านซ้าย และจากนั้นเช็คค่าด้านขวาทีละตัวถ้าทุกตัวใน tree ทั้งคู่เท่ากันจะเป็น tree ที่เท่ากัน
-- ถ้าเป็น empty ด้วยกันทั้ง 2 tree เป็น tree ที่เท่ากัน ถ้าเป็น  empty กับ tree จะไม่เท่ากัน

--how should we define equality for lists?
--  when are two lists equal?
--  เริ่มดูจากค่าแรกใน list ไล่ไปเรื่อยๆจนถึงตัวสุดท้ายถ้าเป็นค่าเดียวกันทั้งหมดตั้งแต่ตัวแรกจนตัวสุดท้ายจะเป็น list ที่เท่ากัน
--  list ว่างทั้งคู่คือ list ที่เท่ากัน ถ้าเป็ฯ list ว่างแค่อันเดียวคือไม่เท่ากัน

--how should we define equality for pairs?
--  when are two pairs equal?
--  ดุว่าตัวแรกเป็นค่าเดียวกัน จากนั้นดูตัวถัดไปว่าเป็นค่าเดียวกันไหมถ้าใช่จะถือว่าเป็น pairs ที่เท่ากัน

--how should we define equality for Maybe?
--  when are two Maybe's equal?
--  ถ้าเป็น nothing ทั้งคู่คือเท่ากัน แต่ถ้าเป็ฯ Just ค่าใน Just ต้องเท่ากันถึงจะถือว่าเป็น Maybe ที่เท่ากัน