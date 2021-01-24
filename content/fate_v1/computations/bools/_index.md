---
title: Booleans
weight: 2
---

All arguments are assumed to be of the same type.

### Conjunction
{{< fatecode >}}(and [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

Standard conjunction (minimum of 2 arguments).

### Disjunction
{{< fatecode >}}(or [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

Standard disjunction (minimum of 2 arguments).

### Negation
{{< fatecode >}}(not [BOOL]){{< /fatecode >}}

Standard negation.

### Implication
{{< fatecode >}}(implies [B0 = BOOL] [B1 = BOOL]){{< /fatecode >}}

Standard implication.

### Exclusivity
{{< fatecode >}}(one_in [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

true if, and only if, exactly one of the operands is true. There needs to be at
least one argument.

### Equality
{{< fatecode >}}(= [C0 = COMPUTATION*] ... [CN = COMPUTATION*]){{< /fatecode >}}
True if, and only if, all operands are equal. Takes at least 2 arguments.

### Strictly less than
{{< fatecode >}}(< [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is strictly lower than `C1`.

### Less than
{{< fatecode >}}(=< [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is lower or equal to/than `C1`.

### Strictly more than
{{< fatecode >}}(> [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is strictly higher than `C1`.

### More than
{{< fatecode >}}(>= [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is higher or equal to/than `C1`.
