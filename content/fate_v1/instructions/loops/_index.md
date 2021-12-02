---
title: Loops
---
Allow the repetition of a group of instructions according to a computation.
Every loop body defines its hierarchy level, from the local variables' point of
view.

### WHILE
{{< fatecode >}}(while [BOOL]
   [I0 = INSTRUCTION]
   ...
   [IM = INSTRUCTION]
){{< /fatecode >}}

Executes `[I0]` ... `[IM]` if, and as long as, `[BOOL]` yields true.

### DO WHILE
{{< fatecode >}}(do_while [BOOL]
   [I0 = INSTRUCTION]
   ...
   [IM = INSTRUCTION]
){{< /fatecode >}}

Executes `[I0]` ... `[IM]`,  and does so again as long as, `[BOOL]` yields
true.

### FOR
{{< fatecode >}}(for
   [PRE = INSTRUCTION]
   [BOOL]
   [POST = INSTRUCTION]

   [I0 = INSTRUCTION]
   ...
   [IM = INSTRUCTION]
){{< /fatecode >}}

Executes `[PRE]`, then, if and as long as `[BOOL]` yields true, executes
`[I0]` ... `[IM]` followed by `[POST]`.

### FOR EACH
{{< fatecode >}}(foreach [COLLECTION] {String}
   [I0 = INSTRUCTION]
   ...
   [IM = INSTRUCTION]
){{< /fatecode >}}

Executes `[I0]` ... `[IM]` for each member of `[COLLECTION]`, in order. The current
member is stored in a new local variable named `{String}`.

### BREAK
{{< fatecode >}}(break!){{< /fatecode >}}

Exits the current loop.
