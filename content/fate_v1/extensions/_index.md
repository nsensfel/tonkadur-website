---
title: Extensions
weight: 9
---

{{< fatecode >}}(declare_extra_instruction {Identifier} [T0 = TYPE] ... [TN = TYPE]){{< /fatecode >}}
Declares an external instruction `{Identifier}` with parameters of type `[T0]`
... `[TN]`.

{{< fatecode >}}(declare_extra_computation [R = TYPE] {Identifier} [T0 = TYPE] ... [TN = TYPE]){{< /fatecode >}}
Declares an external computation `{Identifier}` with parameters of type `[T0]`
... `[TN]` and returning a value of type `[R]`.

{{< fatecode >}}(declare_extra_type {Identifier}){{< /fatecode >}}
Declares an external type.
