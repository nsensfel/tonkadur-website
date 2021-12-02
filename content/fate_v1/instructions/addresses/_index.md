---
title: Addresses
---
### ALLOCATION
{{< fatecode >}}(allocate! [POINTER REFERENCE]){{< /fatecode >}}

Set `[POINTER REFERENCE]` to the address of a new memory location of type
`[TYPE]`. Don't forget to call `free` on it once you're done.

### DE-ALLOCATION
{{< fatecode >}}(free! [POINTER]){{< /fatecode >}}

Removes the memory element at `[POINTER]` from the memory.
