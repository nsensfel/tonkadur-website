---
menuTitle: <Value>
title: Value
weight: 4
---

This page describes the types of values used in Wyrd.

Note that `{Integer}` and `{Float}` are meant to represent the largest available
integer and float point value types available in the interpreter's language.
This is not mandatory, but be especially wary of using too small a type for
`{Integer}`, as the `<State>` `program_counter` value will need to be able to
be as big as there are instructions in the program.

{{< svg "static/images/wyrd_values.drawio.svg" "500px" >}}

