---
title: Computations
weight: 1
---
This page presents all the computations that can be performed in Wyrd.
Computations may access the current memory, but, with one exception, do not
change it. The one exception is `(new t)`. All computations return values.
The terms 'value' and 'computation' are interchangeable.

## CONSTANT
{{< fatecode >}}(const [BASE TYPE] {string}){{< /fatecode >}}
Returns the `[BASE TYPE]` represented by `{string}`.

## CAST
{{< fatecode >}}(cast [COMPUTATION] [BASE TYPE]){{< /fatecode >}}
Converts `[COMPUTATION]` to `[BASE TYPE]`, returns the result.

Note:
* Converting from `FLOAT` to `INT` returns `floor(v)`.
* Converting from `BOOL` to `STRING` yields either `True` or `False`.

The following must be supported:
* `[FLOAT]` to `[FLOAT]`, `[INT]`, and `[STRING]`.
* `[INT]` to `[FLOAT]`, `[INT]`, and `[STRING]`.
* `[BOOL]` to `[BOOL]` and `[STRING]`.
* `[STRING]` to `[BOOL]` (`true` and `false`), `[FLOAT]`, `[INT]`, and`[STRING]`.

## IF-ELSE
{{< fatecode >}}(if_else [BOOL] [C0 = COMPUTATION] [C1 = COMPUTATION]){{< /fatecode >}}
Returns `C0` if `[BOOL]` holds _true_, `C1` otherwise. `C0` and `C1` both
have the same type.

## EQUALS
{{< fatecode >}}(equals [C0 = COMPUTATION] [C1 = COMPUTATION]){{< /fatecode >}}
Returns a `BOOL`, _true_ if `C0` and `C1` hold the same value. `C0` and `C1`
are both of the same type.

## MATHEMATICAL OPERATORS
{{< fatecode >}}(divide [C0 = NUMBER] [C1 = NUMBER]){{< /fatecode >}}

{{< fatecode >}}(minus [C0 = NUMBER] [C1 = NUMBER]){{< /fatecode >}}

{{< fatecode >}}(plus [C0 = NUMBER] [C1 = NUMBER]){{< /fatecode >}}

{{< fatecode >}}(power [C0 = NUMBER] [C1 = NUMBER]){{< /fatecode >}}

{{< fatecode >}}(times [C0 = NUMBER] [C1 = NUMBER]){{< /fatecode >}}
The operation returns a value of the same type as `C0` and `C1` (both `C0` and
`C1` are also of the same type). Thus, `(divide C0 C1)` is an integer division
(the remainder is discarded) if `C0` and `C1` are of type `INT`, and a standard
division if they are of type `FLOAT`.

{{< fatecode >}}(rand [C0 = INT] [C1 = INT]){{< /fatecode >}}
Returns a random value between `C0` and `C1`, inclusive. Raises a runtime error
if `C0 > C1`.

## MATHEMATICAL COMPARISON
{{< fatecode >}}(less_than [C0 = COMPARABLE] [C1 = COMPARABLE]){{< /fatecode >}}
Returns a `[BOOL]` indicating if `C0` is strictly less than `C1`.
`C0` and `C1` are both of the same type.

## LOGICAL OPERATORS
{{< fatecode >}}(and [C0 = BOOL] [C1 = BOOL]){{< /fatecode >}}

{{< fatecode >}}(not [C0 = BOOL]){{< /fatecode >}}

## SIZE
{{< fatecode >}}(size [COLLECTION ADDRESS]){{< /fatecode >}}
Returns the number of elements held by the collection at
`[COLLECTION ADDRESS]`.

## REFERENCES
{{< fatecode >}}(address [COMPUTATION]){{< /fatecode >}}
Returns an `ADDRESS` to the memory element at address `[COMPUTATION]`. Raises a
runtime error if `[COMPUTATION]` is not a memory element.

{{< fatecode >}}(relative_address [R0 = (COLLECTION|STRUCTURE) ADDRESS] [STRING]){{< /fatecode >}}
Returns a `REFERENCE` to member `[STRING]` of `R0`.

{{< fatecode >}}(value_of [ADDRESS]){{< /fatecode >}}
Returns the value held at the memory location `[ADDRESS]`.

{{< fatecode >}}(new [TYPE]){{< /fatecode >}}
Returns an `[TYPE] ADDRESS` to a newly allocated memory element of
type `[TYPE]`.

## RICH TEXT
{{< fatecode >}}(newline){{< /fatecode >}}
Returns a `RICH TEXT` value corresponding to a newline.

{{< fatecode >}}(rich_text [S0 = STRING] ... [SN = STRING]){{< /fatecode >}}
Returns a single value `RICH TEXT` representing the elements `S0` ... `S1`.

{{< fatecode >}}(add_rich_text_effect ({string} [V0 = COMPUTATION] ... [VN = COMPUTATION]) [RICH TEXT]){{< /fatecode >}}
Returns a `RICH TEXT` value of `[RICH TEXT]` with the given effect enabled.

## LAST USER CHOICE
{{< fatecode >}}(get_last_user_choice){{< /fatecode >}}
Returns the number corresponding to the option last chosen by the user in a
`(resolve_choices)`, or `-1` if there is no such value.
