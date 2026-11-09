import plugins
import ./mpairtype

# A plugin template that stands for an OBJECT value: it folds `pairOf(a, b)`
# to the constructor `Pair(x: a, y: b)`, but only once both arguments are
# concrete literals. While either is still a type variable the expansion is
# deferred and the compiler asks again after instantiation.

proc literalInt(n: NifCursor; value: var BiggestInt): bool =
  if n.kind == IntLit:
    value = intValue(n)
    result = true
  elif n.exprKind == SufX and firstChild(n).kind == IntLit:
    value = intValue(firstChild(n))
    result = true
  else:
    result = false

proc transform(n: NifCursor): NifBuilder =
  var arg = callArgs(n)
  var x, y: BiggestInt = 0
  if not literalInt(arg, x):
    return deferExpansion()
  skip arg
  if not literalInt(arg, y):
    return deferExpansion()
  let info = n.info
  result = createTree()
  result.withTree OconstrX, info:
    result.bindSym "Pair"
    result.withTree KvU, info:
      result.addIdent "x"
      result.addIntLit x
    result.withTree KvU, info:
      result.addIdent "y"
      result.addIntLit y

let input = loadPluginInput()
saveTree transform(input)
