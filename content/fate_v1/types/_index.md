---
title: Types
weight: 2
---

Fate is a strongly typed language. All values have a well defined type. All
variables and parameters are assigned a type which cannot be changed.

### Numbers
There are two types corresponding to numbers: `int` and `float`.

The `int` type corresponds to an integer, which is a number *without*
fractional component. Examples of `[INT]` values include:
* {{< fatecode >}}42{{< /fatecode >}}
* {{< fatecode >}}-4{{< /fatecode >}}
* {{< fatecode >}}(+ 63 -5 1 8 9 (- 22 0 1 3)){{< /fatecode >}}
* {{< fatecode >}}(/ 3 2){{< /fatecode >}}

The `float` type corresponds to a number *with* a fractional component. Examples
of `[FLOAT]` values include:
* {{< fatecode >}}42.0{{< /fatecode >}}
* {{< fatecode >}}69.4201773{{< /fatecode >}}
* {{< fatecode >}}(+ 63.25 9.8 0.2224 (- 0.11 0.9 .99993)){{< /fatecode >}}
* {{< fatecode >}}(/ 3.0 2.0){{< /fatecode >}}

This documentation uses the `[NUMBER]` notation to indicate values that can
be either `[FLOAT]` or `[INT]`.

### Booleans
The `bool` type corresponds to Booleans. This type only accepts two values:
`(true)` and `(false)`.

Examples of `[BOOL]` values include:
* {{< fatecode >}}(true){{< /fatecode >}}
* {{< fatecode >}}(and (false) (true) (false)){{< /fatecode >}}
* {{< fatecode >}}(or (false) (true) (false)){{< /fatecode >}}
* {{< fatecode >}}(one_in (false) (true) (false)){{< /fatecode >}}

### Texts and Strings
Things get a bit more complicated when handling texts and strings. There are two
types here `string` and `text`.

The `string` type corresponds to string constants. Nothing can be added to a
`string` value. Its use is fairly limited. The main point of the `string` type
being that it is comparable and thus a good way to handle tags (e.g. testing
for player progress by having a set of `[STRING]` values corresponding to what
has been done so far).

Examples of `[STRING]` include:
* {{< fatecode >}}something like this{{< /fatecode >}}
* {{< fatecode >}}日本のもの{{< /fatecode >}}
* {{< fatecode >}}لاشياء العربية{{< /fatecode >}}
* {{< fatecode >}}There are forty two (lp)42(rp) things there...{{< /fatecode >}}
* {{< fatecode >}}9 + x = 3 is an equation.{{< /fatecode >}}

The `text` corresponds to trees of computations interpreted as text and to which
attributes can be added. In simpler terms: it's text. If the use of comparable
values is not needed, `text` is the type to use for text.
Examples of `[TEXT]` include:
* Every example of `[STRING]`.
* {{< fatecode >}}There are (+ 32 44 11 4) eggs in that basket.{{< /fatecode >}}
* {{< fatecode >}}There are (text_effect italics (+ 32 44 11 4) eggs) in that basket!{{< /fatecode >}}
* {{< fatecode >}}There are (text_effect italics (+ 32 44 11 4) (text_effect bold eggs)) in that basket!{{< /fatecode >}}
* {{< fatecode >}}(newline)- This!{{< /fatecode >}}

### Pointers
A pointer is a value corresponding to the address of a memory element.
Accessing the value of the pointer yields the address, accessing the value
pointed to by the value of the pointer yields the memory element.  Pointers
still have to point to a specific type: unlike in C, you cannot create a pointer
to an unspecified type.

In effect, a pointer to a memory element of type `{TYPE}` is written as
`(ptr {TYPE})`.

Examples of pointer types:
* {{< fatecode >}}(ptr int){{< /fatecode >}}
* {{< fatecode >}}(ptr (ptr int)){{< /fatecode >}}
* {{< fatecode >}}(ptr text){{< /fatecode >}}
* {{< fatecode >}}(ptr (cons int sequence)){{< /fatecode >}}

### Collections
Collections are memory elements containing any number of elements of a given
type. Two types of collections are available in Fate: lists and sets.

Lists are basic collections in which the order of the elements is fully
controlled by the user. The `(list {TYPE})` type indicates a list of `{TYPE}`.

Examples of list types:
* {{< fatecode >}}(list int){{< /fatecode >}}
* {{< fatecode >}}(list (list (ptr int))){{< /fatecode >}}
* {{< fatecode >}}(list (cons (list int) (set int))){{< /fatecode >}}

Examples of lists:
* {{< fatecode >}}(range 0 10 1){{< /fatecode >}}
* {{< fatecode >}}(add 0 1 2 3 4 (default (list int))){{< /fatecode >}}
* {{< fatecode >}}(add_all (range 0 10 1) (range -10 -1 1)){{< /fatecode >}}

Sets are collections of elements with a comparable type. The comparables types,
noted `[COMPARABLE]` are `int`, `float`, `bool`, `string`, `sequence`, `lambda`,
and `ptr`. This corresponds to types for which operators such as `<` are
defined. Sets cannot have duplicate members, and their elements are ordered in
a specific way in order to more quickly test if a value is present. the
`(set {COMPARABLE TYPE})` indicates a set of elements of type
`{COMPARABLE TYPE}`.

Examples of set types:
* {{< fatecode >}}(set int){{< /fatecode >}}
* {{< fatecode >}}(set (lambda int (int (list text)))){{< /fatecode >}}
* {{< fatecode >}}(set string){{< /fatecode >}}

Examples of sets:
* {{< fatecode >}}(add 6 1 4 2 900 (default (set int))){{< /fatecode >}}
* {{< fatecode >}}(add_all (range 0 10 1) (set int)){{< /fatecode >}}

### Lambda Expressions
Lambda expressions are similar to a computation that is stored for later use.
This can have different uses, such as applying the same computation on a
collection of elements or storing a recurrent computation with a value that
changes over time.

The lambda expression itself is a computation, so it has a type (not to be
confused with the type of value returned by the expression when it is computed).

Lambda expression types are noted
`(lambda {R = TYPE} ({A0 = TYPE} ... {AN = TYPE}))`, with `{R}` being the type
of value returned by the expression and `{A0}` ... `{AN}` being the type of
each of its parameters.

Examples of lambda expression types:
* {{< fatecode >}}(lambda int ()){{< /fatecode >}}
* {{< fatecode >}}(lambda int (int (list text))){{< /fatecode >}}
* {{< fatecode >}}(lambda (lambda int ()) (int string)){{< /fatecode >}}

Examples of lambda expressions:
* {{< fatecode >}}(lambda ((int i)) (+ i 1)){{< /fatecode >}}
* {{< fatecode >}}(lambda ((int i) (int j)) (max j (+ i 2))){{< /fatecode >}}
* {{< fatecode >}}(lambda
   ((string s) (int i) (int j))
   (if (= (var s) zero)
      0
      (* j (+ i 2))
   )
){{< /fatecode >}}

### Sequences and Procedures
It is possible to use values that correspond to a sequence or a procedure.
The type `(sequence ({A0 = TYPE} ... {AN = TYPE}))` corresponds to a sequence
or procedure taking parameters of types `{A0}` ... `{AN}`.

Examples of procedure types:
* {{< fatecode >}}(sequence ()){{< /fatecode >}}
* {{< fatecode >}}(sequence (int int)){{< /fatecode >}}
* {{< fatecode >}}(sequence (float string int)){{< /fatecode >}}

Examples of computations returning a sequence or procedure value:
* {{< fatecode >}}(sequence my_seq_name){{< /fatecode >}}
* {{< fatecode >}}(sequence my_other_seq_name){{< /fatecode >}}

### Common Type Groupings
* `[NUMBER]` corresponds to `[INT]` or `[FLOAT]`.
* `[COLLECTION]` corresponds to `[LIST]` or `[set]`.
* `[PRIMITIVE]` corresponds to `[INT]`, `[FLOAT]`, `[BOOL]`, `[STRING]`,
  or `[TEXT]`.
* `[COMPARABLE]` corresponds to `[INT]`, `[FLOAT]`, `[BOOL]`, `[STRING]`,
  `[SEQUENCE]`, `[LAMBDA]`, or `[PTR]`.

## Defining Your Own Types

### Aliasing
{{< fatecode >}}(declare_alias_type {TYPE} {IDENTIFIER}){{< /fatecode >}}.
**Effect:** Declares the type `{IDENTIFIER}`.

* If `{TYPE}` is not a `[PRIMITIVE]`: `{TYPE}` and `{IDENTIFIER}` are now two
  equivalent types.

* If `{TYPE}` is a `[PRIMITIVE]`, `{IDENTIFIER}` is a subtype of `{TYPE}`. Given
  `T0` and `T1` two types, such that `T1` is a subtype of `T0`, `T1` can be used
  as a `T0`, but `T0` cannot be used as `T1`.

### Structures
{{< fatecode >}}(declare_structure_type {IDENTIFIER}
   ({T0 = TYPE} {F0 = IDENTIFIER})
   ...
   ({TN = TYPE} {FN = IDENTIFIER})
){{< /fatecode >}}.

{{< fatecode >}}(define_structure_type player
   (creature creature)
   ((list (ptr item)) inventory)
   (int money)
){{< /fatecode >}}
