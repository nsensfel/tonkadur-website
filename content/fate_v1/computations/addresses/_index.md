---
title: Addresses
---
### VALUE ACCESS
{{< fatecode >}}(at [ADDRESS]){{< /fatecode >}}

Returns the variable at `[ADDRESS]`.

### ALLOCATION
{{< fatecode >}}(new [TYPE]){{< /fatecode >}}

Returns the address of a new variable of type `[TYPE]`. Don't forget to call
`free` on it once you're done.

### ADDRESS
{{< fatecode >}}(ptr [COMPUTATION VARIABLE]){{< /fatecode >}}

Returns the address of `[COMPUTATION VARIABLE]`.
