---
title: Collections
---
Fate supports two types of collections: `[LIST]`, which are basic, unordered
lists; and `[SET]`, which are ordered lists, but only useable with
`[COMPARABLE]` elements.

### ADDING A MEMBER
{{< fatecode >}}(add_element! [C0 = COMPUTATION*] ... [CN = COMPUTATION*] [COLLECTION VAR]){{< /fatecode >}}

Adds `C0` ... `CN` to `[COLLECTION VAR]`. If `[COLLECTION VAR]` is a `[LIST]`,
the new members are added at the end of the list, in order (meaning that the
list then ends with `CN`). Note that `[COMPUTATION*]` does not support use of
the variable shorthand.

### ADDING A MEMBER AT INDEX
{{< fatecode >}}(add_element_at! [INT] [COMPUTATION*] [LIST VAR]){{< /fatecode >}}

Adds `[COMPUTATION*]` to `[LIST VAR]` at index `[INT]`. If `[INT]` is less than
0, the element is added at the start of the list, and if `[INT]` is greater or
equal to the size of the list, the element is added at the end of the list. Note
that `[COMPUTATION*]` does not support use of the variable shorthand.

### ADDING MEMBERS
{{< fatecode >}}(add_all_elements! [COLLECTION] [COLLECTION VAR]){{< /fatecode >}}

Adds all the elements of `[COLLECTION]` to `[COLLECTION VAR]`. If
`[COLLECTION VAR]` is a `[LIST]`, the new members are added at the end of the
list.

### EMPTYING COLLECTIONS
{{< fatecode >}}(clear [COLLECTION]){{< /fatecode >}}

Removes all members of `[COLLECTION]`.

### REMOVING MEMBER
{{< fatecode >}}(remove [COMPUTATION] [COLLECTION]){{< /fatecode >}}

Removes the first member of `[COLLECTION]` equal to `[COMPUTATION]`.

### REMOVING MEMBERS
{{< fatecode >}}(remove_all [COMPUTATION] [COLLECTION]){{< /fatecode >}}

Removes all instances of  `[COMPUTATION]` from `[COLLECTION]`.

### REMOVING AT INDEX
{{< fatecode >}}(remove_at [INT] [COLLECTION]){{< /fatecode >}}

Removes the element of `[COLLECTION]` at `[INT]`.

### REVERSING LISTS
{{< fatecode >}}(reverse [LIST]){{< /fatecode >}}

Reverses the order of the members of `[LIST]`.

### FILTER ELEMENTS
{{< fatecode >}}(filter! [LAMBDA BOOL (X)] [X COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(filter! [LAMBDA BOOL (X Y0 ... YN)] [X COLLECTION VAR] [Y0 COMPUTATION*] ... [YN COMPUTATION*]){{< /fatecode >}}
Modifies `[X COLLECTION VAR]` so that only the elements for which
`[LAMBDA BOOL (X)]` returns `true` remain. If the lambda function needs extra
parameters, use the second syntax, which adds those parameters at the end of the
`(filter! ...)` call. Note that the variable shorthand cannot be used for these
extra parameters.

### FILTER ELEMENTS (INDEXED)
{{< fatecode >}}(indexed_filter! [LAMBDA BOOL (INT X)] [X COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(indexed_filter! [LAMBDA BOOL (INT X Y0 ... YN)] [X COLLECTION VAR] [Y0 COMPUTATION*] ... [YN COMPUTATION*]){{< /fatecode >}}
Modifies `[X COLLECTION VAR]` so that only the elements for which
`[LAMBDA BOOL (INT X)]` (with the `INT` being the element's index) returns
`true` remain. If the lambda function needs extra parameters, use the second
syntax, which adds those parameters at the end of the `(indexed_filter! ...)`
call.  Note that the variable shorthand cannot be used for these extra
parameters.

### MERGE COLLECTIONS
{{< fatecode >}}(merge! [LAMBDA Y (X Y)] [X COLLECTION] [Y COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(merge! [LAMBDA Y (X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION VAR] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}


### SAFE-MERGE COLLECTIONS
{{< fatecode >}}(safe_merge! [LAMBDA Y (X Y)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(safe_merge! [LAMBDA Y (X Y Z0 ... ZN)] [X COLLECTION] [X COMPUTATION*] [Y COMPUTATION*] [Y COLLECTION VAR] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}

### MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(indexed_merge! [LAMBDA Y (INT X Y)] [X COLLECTION] [Y COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(indexed_merge! [LAMBDA Y (INT X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION VAR] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}

### SAFE-MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(safe_indexed_merge! [LAMBDA Y (INT X INT Y)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION VAR]){{< /fatecode >}}
{{< fatecode >}}(safe_indexed_merge! [LAMBDA Y (INT X INT Y Z0 ... ZN)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION VAR] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
