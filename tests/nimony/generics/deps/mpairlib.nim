import ./mpairtype

template pairOf*(a, b: int): Pair {.plugin: "mpairof".}

type
  Box*[P: static[Pair]; T] = object
    val*: T

proc box*[A, B: static[int]; T](v: T): Box[pairOf(A, B), T] =
  Box[pairOf(A, B), T](val: v)

proc take*[A, B: static[int]; T](b: Box[pairOf(A, B), T]): T =
  b.val

proc sumOf*[P: static[Pair]; T](b: Box[P, T]): int =
  P.x + P.y
