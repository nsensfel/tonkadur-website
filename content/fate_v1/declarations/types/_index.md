---
title: Types
---
Fate is a strongly typed language.

## Base Types
There are a few base types already defined:

* `int`: an integer, which is a number *without* fractional component (e.g. `-3`, `0`, `3`).
* `float`: a number *with* a fractional component (e.g. `-3.14`, `0.0`, `3.9931`).
* `bool`: a Boolean (i.e. `(true)` or `(false)`).
* `string`: a list of characters, not including newlines (e.g. `bob`,
  `something else`, `日本のもの`, or `الاشياء العربية`). This cannot include
  computations: only hardcoded strings. `(lp)` will be substituted by a `(` and
  `(rp)` by a `)`, letting you use parentheses in a string.

* `text`: a list of computations, interpreted as text, which may have
  attributes.

Pointers are also available:
* `(ptr [TYPE])`: a pointer to a memory element of type `[TYPE]` (e.g. `(ptr int)`, `(ptr (ptr string))`).
If you are not familiar with pointers, a pointer is a value corresponding to an address containing a memory element.
Accessing the value of the pointer yields the address, accessing the value pointed to by the value of the pointer yields the memory element.
Pointers to pointers can be made, in which case that memory element is also an address to yet another memory element.
Pointers still have to point to a definite type. Unlike in C, you cannot create a pointer to an unspecified type.

Two collection types are available:
* `(list [TYPE])`
* `(set [COMPARABLE TYPE])`

Lambda computations are available:
* `(lambda [R = TYPE] ([A0 = TYPE] ... [AN = TYPE]))` is a type corresponding
  to a lambda function returning a value of type `R` and taking parameters of
  types `A0` ... `AN`.

### Common Type Groupings
* `[NUMBER]` corresponds to `int`, `float`.
* `[COLLECTION]` corresponds to `(list [TYPE])` and `(set [COMPARABLE TYPE])`.
* `[PRIMITIVE]` `int`, `float`, `bool`, `string`, `rich_text`.
* `[COMPARABLE]` corresponds to `int`, `float`, `bool`, `string`, `rich_text`,
  and `(ptr [TYPE])`. This indicates types for which operators such as `<` are
  defined.

## Defining Your Own Types

### Aliasing
{{< fatecode >}}(declare_alias_type [TYPE] {String}){{< /fatecode >}}.
**Effect:** Declares the type `{String}`. If `[TYPE]` is not a `[PRIMITIVE]`,
   `[TYPE]` and `{String}` are now two equivalent types. If `[TYPE]` is a
   `[PRIMITIVE]`, `{String}` is a subtype of `[TYPE]`.

### Structures
{{< fatecode >}}(declare_structure_type {String} ([T0 = TYPE] {F0 = String}) ... ([TN = TYPE] {fn = String})){{< /fatecode >}}.

## Examples

{{< fatecode >}}(define_structure_type player
   (creature creature)
   ((list (ptr item)) inventory)
   (int money)
)
{{< /fatecode >}}
