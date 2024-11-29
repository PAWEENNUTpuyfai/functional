join :: ([a], [a]) -> [a]
join([],y) = y
join(x:xs,y) = x:join(xs,y)

rev [] = []
rev (x:xs) = join (rev xs, [x])
--how long does join take?
--  O(n)
--how long does your rev take to compute the reverse of a list
--  O(n^2)
--are you satisfied with the running time?
-- if not, what would you like to do to improve the efficiency?
--  ไม่ คิดว่าสามารถพัฒนาได้ด้วยการหาทางที่เอาตัวแรกที่อ่านมาได้ไปไว้เป็นตัวสุดท้ายของ list ได้เลย


fib :: Integral p => p -> p
fib n
    | n == 0    = 0
    | n == 1    = 1
    | n > 1     = fib (n-1) + fib (n-2)
    | otherwise = error "negative number"
--what's the type of your fib?--  fib :: Integral p => p -> p
--how long does your fib take to compute fib n?
--  O(2^n)
--are you satisfied with the running time?
-- if not, what would you like to do to improve the efficiency?
--  ไม่ คิดว่าสามารถแก้ด้วยการเก็บค่าของแต่ละ fib(n) ที่เคยคำนวณไว้แล้วเก็บไปใช้ซ้ำได้

fib' n = fib_aux 0 0 1
  where
    fib_aux i res res'
      | i == n    = res
      | otherwise =
          fib_aux (i+1) res' (res+res')
