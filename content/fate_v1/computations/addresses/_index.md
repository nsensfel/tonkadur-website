---
title: Addresses
---

Addresses are values that indicate where in the memory some other value is
located. They can thus be used to pass around an indication of where to modify
a value.

### VALUE ACCESS
{{< fatecode >}}(at [address: (POINTER X)]){{< /fatecode >}}
Returns the `[X]` value at `[address]`. The returned value can act as a
reference.

**Examples:** `(at my_ptr_var)`, `(at (ptr my_var))`

**Aliases:** `at`.

### ADDRESS
{{< fatecode >}}(ptr [X]){{< /fatecode >}}

Returns the address of `[COMPUTATION VARIABLE]`.

**Examples:** `(ptr my_var)`

**Aliases:** `address_of`, `addressof`, `addressOf`, `address`, `addr`,
`pointer_to`, `pointerto`, `pointerTo`, `pointer`, `ptr`, `reference_to`,
`referenceto`, `referenceTo`, `reference`, `ref`.
