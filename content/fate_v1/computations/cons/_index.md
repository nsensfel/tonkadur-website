---
title: Cons
---
Fate features a *construct* computation, making it possible to create an
anonymous structure by creating pairs of computations. Unlike collections, these
pairs do not have to be made of computations of the same type.

### PAIRING
{{< fatecode >}}(cons [C0 = COMPUTATION*] [C1 = COMPUTATION*]){{< /fatecode >}}

Returns the value corresponding to a pair made of `[C0]` and `[C1]`. Note that
the variable shorthand cannot be used for either parameter.

### RETRIEVING THE FIRST ITEM
{{< fatecode >}}(car [CONS]){{< /fatecode >}}

Returns the value corresponding to the first item in the `[CONS]` pair.

### RETRIEVING THE SECOND ITEM
{{< fatecode >}}(cdr [CONS]){{< /fatecode >}}

Returns the value corresponding to the second item in the `[CONS]` pair.
