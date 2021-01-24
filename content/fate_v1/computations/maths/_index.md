---
title: Mathematics
weight: 1
---

All operands must be of the same type, which is also the type returned by the
operation.

### Addition
{{< fatecode >}}(+ [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard addition (minimum of 2 arguments).

### Substraction
{{< fatecode >}}(- [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard substraction (minimum of 2 arguments).

### Multiplication
{{< fatecode >}}(* [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard multiplication (minimum of 2 arguments).

### Division
{{< fatecode >}}(/ [N0 = NUMBER] [N1 = NUMBER]){{< /fatecode >}}

Standard division. Note that a division on integers is indeed an integer
division.

### Exponent
{{< fatecode >}}(^ [N0 = NUMBER] [N1 = NUMBER]){{< /fatecode >}}

Standard exponentiation.

### Modulo
{{< fatecode >}}(% [I0 = INT] [I1 = INT]){{< /fatecode >}}

Standard modulo operation.

### Minimum
{{< fatecode >}}(min [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Lowest value among the operands (minimum of 2 arguments).

### Maximum
{{< fatecode >}}(max [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Highest value among the operands (minimum of 2 arguments).

### Clamp
{{< fatecode >}}(clamp [N0 = NUMBER] [N1 = NUMBER] [N2 = NUMBER]){{< /fatecode >}}

Equivalent to `(max N0 (min N1 N2))`.

### Absolute
{{< fatecode >}}(abs [NUMBER]){{< /fatecode >}}

Positive value of `[NUMBER]`.
