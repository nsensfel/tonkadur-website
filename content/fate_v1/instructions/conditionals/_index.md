---
title: Conditionals
---
Allow the control of whether to execute instructions or not according to a
computation. Every conditional branch defines its hierarchy level, from the
local variables' point of view.

### IF
{{< fatecode >}}(if [BOOL] [INSTRUCTION]){{< /fatecode >}}

Executes `[INSTRUCTION]` if, and only if, `[BOOL]` yields true.

### IF-ELSE
{{< fatecode >}}(if_else [BOOL] [IF_TRUE = INSTRUCTION] [IF_FALSE = INSTRUCTION]){{< /fatecode >}}

Executes `[IF_TRUE]` if `[BOOL]` yields true, but `[IF_FALSE]` if it does not.

### COND
{{< fatecode >}}(cond ([C0 = BOOL] [I0 = INSTRUCTION]) ... ([CN = BOOL] [IN = INSTRUCTION])){{< /fatecode >}}

Executes `[II]`, such that `[CI]` is the first listed boolean to yield true.

### SWITCH
{{< fatecode >}}(switch [T = COMPUTATION] ([C0 = COMPUTATION] [I0 = INSTRUCTION]) ... ([CN = COMPUTATION] [IN = INSTRUCTION]) [DEFAULT = INSTRUCTION]){{< /fatecode >}}

Executes `[II]`, such that `[CI]` is the first listed computation to be equal
to `[T]`. Executes `[DEFAULT]` if there is no such `[CI]`.
