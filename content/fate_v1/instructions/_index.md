---
title: Instructions
weight: 3
---
Instructions do not return values, but modify the memory in some way or
interact with the interpreter. Computations are valid instructions, and will be
automatically converted into `[TEXT]` to be displayed.

### ASSERT
{{< fatecode >}}(assert [BOOL] [TEXT]){{< /fatecode >}}

Raises the exception `[TEXT]` to the interpreter if `[BOOL]` yields
false.

### DONE
{{< fatecode >}}(done){{< /fatecode >}}

Completes the execution of the current sequence.

### END
{{< fatecode >}}(end){{< /fatecode >}}

Completes the execution of the script.

### SET VALUE
{{< fatecode >}}(set [REFERENCE] [COMPUTATION]){{< /fatecode >}}

Gives the value `[COMPUTATION]` to `[REFERENCE]`.

### VISIT SEQUENCE
{{< fatecode >}}(visit {String} [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

{{< fatecode >}}(visit [SEQUENCE] [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

Visits the sequence named `{String}` (or stored in `[SEQUENCE]`), with `C0` ...
`CN` as arguments. That sequence does not need to already have been defined.
Visiting a sequence means that the execution of the current sequence continues
once the visited sequence has completed.

### JUMP TO SEQUENCE
{{< fatecode >}}(jump_to {String} [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

{{< fatecode >}}(jump_to [SEQUENCE] [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

Jumps to the sequence named `{String}` (or stored in `[SEQUENCE]`), with `C0`
... `CN` as arguments. That sequence does not need to already have been
defined. Jumping to a sequence means that the execution of the current sequence
is replaced by that of the target sequence.

### INSTRUCTION LIST
{{< fatecode >}}([C0 = INSTRUCTION] ... [CN = INSTRUCTION]){{< /fatecode >}}

Instruction corresponding to the execution of `[C0]` ... `[CN]` in order.
