---
title: Lambda Functions
---
Lambda functions are values that correspond to a computation not yet performed.
These can take arguments. Defining a lambda function returns the value that
corresponds to the function itself, the `eval` computation must be used to
obtain the value that the function computes.

### DEFINITION
{{< fatecode >}}(lambda (([T0 = TYPE] {S0 = String}) ... ([TN = TYPE] {SN = String})) [COMPUTATION]){{< /fatecode >}}

Returns a lambda function taking `S0` ... `SN` of types `T0` ... `TN` as
arguments and evaluating to `[COMPUTATION]`.

### EVALUATION
{{< fatecode >}}(eval [REFERENCE] [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}

Returns the result of evaluating the lambda function at `[REFERENCE]` given the
parameters `C0` ... `CN`.

## Examples
{{< fatecode >}}(lambda ( (int i) )
   (+ (var i) 1)
)
{{< /fatecode >}}

{{< fatecode >}}(lambda ( (int i) )
   (* (eval int_to_int (var i)) 2)
)
{{< /fatecode >}}
