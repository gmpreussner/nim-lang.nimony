template zero[T: SomeInteger](x: typedesc[T]): T = 0.T

proc isEqual1[T: SomeInteger](a: T, b: T = T.zero): bool =
  a == b

proc isEqual2[T](a: T, b: T = T.zero): bool {.untyped.} =
  a == b

proc withCast[T: SomeInteger](a: T, b: T = T(7)): bool =
  a == b

discard isEqual1(1, 2)
discard not isEqual1(1)
discard withCast(3, 3)
discard not withCast(3)
