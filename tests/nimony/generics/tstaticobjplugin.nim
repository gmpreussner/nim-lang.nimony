import std/syncio
import deps/mpairlib

# A deferred plugin call in an object-valued static slot of a parameter type,
# `Box[pairOf(A, B), T]`, folds during overload resolution once explicit
# generic arguments bind `A` and `B`, and then matches the argument's concrete
# `Pair` value. `pairOf` is never visible here, so the fold must not rely on
# call-site scope.

let b23 = box[2, 3, int](7)
echo take[2, 3, int](b23)   # 7
echo sumOf(b23)             # 5
