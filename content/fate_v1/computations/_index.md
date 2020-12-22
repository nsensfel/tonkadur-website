---
title: Computations
weight: 2
---
Computations are values. They may read from the memory, but do not modify it
(with a single exception).

### TEXT
{{< fatecode >}}(text [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

Returns a `text` node containing the text representation of `C0` ... `CN`.

### VARIABLE | REFERENCE
{{< fatecode >}}(var {String}){{< /fatecode >}}

Returns the value of the variable `{String}`, or a reference to it if
applicable. Structure members can be accessed by using `.` in `{String}`.

### STRUCTURE FIELD ACCESS
{{< fatecode >}}{Structure Var Name}.{Field Name}{{< /fatecode >}}
{{< fatecode >}}(field [STRUCTURE VAR] {String}){{< /fatecode >}}

Accesses the `{String}` field of the structure `[STRUCTURE VAR]`. Using `.` to
access fields is recommended over the use of this operator.

### STRUCTURE FIELD VALUE
{{< fatecode >}}(get_field [STRUCTURE] {String}){{< /fatecode >}}
Returns the value of the `{String}` field of the structure `[STRUCTURE]`.

### TEMPORARY VARIABLES
{{< fatecode >}}(let (({V0 = String} [C0 = COMPUTATION]) ... ({VN = String} [CN = COMPUTATION])) [R = COMPUTATION]){{< /fatecode >}}

Defines a hierarchical level and local variables `V0` ... `VN` with values `C0` ... `CN`, and returns the value of `[R]`.

### CAST
{{< fatecode >}}(cast [TYPE] [COMPUTATION*]){{< /fatecode >}}

Transforms `[COMPUTATION*]` into a value of type `[TYPE]`. Note that the variable
shorthand cannot be used for `[COMPUTATION*]`. The following type changes are
allowed:
* `[FLOAT]` to `[FLOAT]`, `[INT]`, and `[STRING]`.
* `[INT]` to `[FLOAT]`, `[INT]`, and `[STRING]`.
* `[BOOL]` to `[BOOL]` and `[STRING]`.
* `[STRING]` to `[BOOL]` (`true` and `false`), `[FLOAT]`, `[INT]`, and`[STRING]`.

### RANDOM NUMBER
{{< fatecode >}}(rand [I0 = INT] [IN = INT]){{< /fatecode >}}

Returns a random number between `I0` and `IN` (inclusive).

## Basic Operators
### BOOL OPERATORS
{{< fatecode >}}(and [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

Standard conjunction (minimum of 2 arguments).

{{< fatecode >}}(or [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

Standard disjunction (minimum of 2 arguments).

{{< fatecode >}}(not [BOOL]){{< /fatecode >}}

Standard negation.

{{< fatecode >}}(implies [B0 = BOOL] [B1 = BOOL]){{< /fatecode >}}

Standard implication.


{{< fatecode >}}(one_in [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}

true if, and only if, exactly one of the operands is true.

### MATH OPERATORS
All operands must be of the same type, which is also the type returned by the
operation.

{{< fatecode >}}(+ [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard addition (minimum of 2 arguments).

{{< fatecode >}}(- [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard substraction (minimum of 2 arguments).

{{< fatecode >}}(* [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Standard multiplication (minimum of 2 arguments).

{{< fatecode >}}(/ [N0 = NUMBER] [N1 = NUMBER]){{< /fatecode >}}

Standard division. Note that a division on integers is indeed a integer
division.

{{< fatecode >}}(^ [N0 = NUMBER] [N1 = NUMBER]){{< /fatecode >}}

Standard exponentiation.

{{< fatecode >}}(% [I0 = INT] [I1 = INT]){{< /fatecode >}}

Standard modulo operation.

{{< fatecode >}}(min [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Lowest value among the operands.

{{< fatecode >}}(max [N0 = NUMBER] ... [NN = NUMBER]){{< /fatecode >}}

Highest value among the operands.

{{< fatecode >}}(clamp [N0 = NUMBER] [N1 = NUMBER] [N2 = NUMBER]){{< /fatecode >}}

Equivalent to `(min N0 (max N1 N2))`.


{{< fatecode >}}(abs [NUMBER]){{< /fatecode >}}

Positive value of `[NUMBER]`.

### COMPARISON OPERATORS
{{< fatecode >}}(= [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

True if, and only if, all operands are equal.

{{< fatecode >}}(< [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is strictly lower than `C1`.

{{< fatecode >}}(=< [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is lower or equal to/than `C1`.

{{< fatecode >}}(> [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is strictly higher than `C1`.

{{< fatecode >}}(>= [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}

True if, and only if, `C0` is higher or equal to/than `C1`.
