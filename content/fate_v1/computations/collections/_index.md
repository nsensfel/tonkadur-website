---
title: Collections
---
### ACCESS
{{< fatecode >}}(access [INT] [COLLECTION|COLLECTION PTR]){{< /fatecode >}}

Returns the value of the `[INT]`th element in `[COLLECTION|COLLECTION PTR]`.

### ACCESS CONSTANT INDEX
{{< fatecode >}}[(COLLECTION|COLLECTION PTR) VAR].{Integer}{{< /fatecode >}}

Returns a variable corresponding to the `[INT]`th element in
`[(COLLECTION|COLLECTION PTR) VAR]`.

### ACCESS POINTER
{{< fatecode >}}(access_pointer [INT] [(COLLECTION|COLLECTION PTR) VAR]){{< /fatecode >}}

Returns a pointer to the `[INT]`th element in `[(COLLECTION|COLLECTION PTR)
VAR]`.

### ADD ELEMENT AT
{{< fatecode >}}(add_element_at [INT] [COMPUTATION*] [LIST]){{< /fatecode >}}

Returns a copy of `[LIST]` with `[COMPUTATION*]` added at index `[INT]`. Note
that `[COMPUTATION*]` does not allow use of the variable shorthand.

### ADD ELEMENT
{{< fatecode >}}(add_element [C0 = COMPUTATION*] ... [CN = COMPUTATION*] [COLLECTION]){{< /fatecode >}}

Returns a copy of `[COLLECTION]` with `C0` ... `CN` added. If `[COLLECTION]`
is a `[LIST]`, then the elements are added at the end of the list, in order
(meaning that `CN` will be the last element added).
Note that `[COMPUTATION*]` does not allow use of the variable shorthand.

### ADDING MEMBERS
{{< fatecode >}}(add_all_elements [C0 = COLLECTION] [C1 = COLLECTION]){{< /fatecode >}}

Returns a copy of `[C1]`, with all the elements of `[C2]` added. If `[C1]`
is a `[LIST]`, the new members are added at the end of the list.

### COUNT
{{< fatecode >}}(count [COMPUTATION*] [COLLECTION]){{< /fatecode >}}

Returns the number of occurrences of `[COMPUTATION*]` in `[COLLECTION]`.
Note that `[COMPUTATION*]` does not allow use of the variable shorthand.

### INDEX OF
{{< fatecode >}}(index_of [COMPUTATION] [COLLECTION]){{< /fatecode >}}

Returns the index of the first occurrence of `[COMPUTATION]` in `[COLLECTION]`,
starting at 0.

### IS MEMBER
{{< fatecode >}}(is_member [COMPUTATION] [COLLECTION]){{< /fatecode >}}

Returns true if, and only if, `[COMPUTATION]` is in `[COLLECTION]`.

### SIZE
{{< fatecode >}}(size [COLLECTION]){{< /fatecode >}}

Returns the size (`[INT]`) of `[COLLECTION]`.

### IS EMPTY
{{< fatecode >}}(is_empty [COLLECTION]){{< /fatecode >}}

Returns true if, and only if `[COLLECTION]` is empty.

### FILTER ELEMENTS
{{< fatecode >}}(filter [LAMBDA BOOL (X)] [X COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(filter [LAMBDA BOOL (X Y0 ... YN)] [X COLLECTION] [Y0 COMPUTATION*] ... [YN COMPUTATION*]){{< /fatecode >}}

Returns a copy of `[X COLLECTION]` in which only the elements for which
`[LAMBDA BOOL (X)]` returns `true` remain. If the lambda function needs extra
parameters, use the second syntax, which adds those parameters at the end of the
`(filter ...)` call. Note that the variable shorthand cannot be used for these
extra parameters.

### FILTER ELEMENTS (INDEXED)
{{< fatecode >}}(indexed_filter [LAMBDA BOOL (INT X)] [X COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(indexed_filter [LAMBDA BOOL (INT X Y0 ... YN)] [X COLLECTION] [Y0 COMPUTATION*] ... [YN COMPUTATION*]){{< /fatecode >}}

Returns a copy of `[INT X COLLECTION]` in which only the elements for which
`[LAMBDA BOOL (INT X)]` (with `INT` being the element's index) returns `true`
remain. If the lambda function needs extra parameters, use the second syntax,
which adds those parameters at the end of the `(indexed_filter ...)` call. Note
that the variable shorthand cannot be used for these extra parameters.

### FOLD OVER COLLECTION
{{< fatecode >}}(foldl [LAMBDA X (X Y)] [X COMPUTATION*] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(foldl [LAMBDA X (X Y Z0 ... ZN)] [X COMPUTATION*] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(foldr [LAMBDA X (X Y)] [X COMPUTATION*] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(foldr [LAMBDA X (X Y Z0 ... ZN)] [X COMPUTATION*] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}

Returns the result of iterating `[LAMBDA X (X Y)]` over `[Y COLLECTION]`, with
`[X COMPUTATION*]` being the initial value. The direction of the iteration is
by ascending index order when using `foldl`, and the opposite order when using
`foldr`. Extra parameters for the lambda function can be passed as extra
parameters of the call. Note that the variable shorthand cannot be used for
those extra parameters, nor for the initial value.

### MERGE COLLECTIONS
{{< fatecode >}}(merge_to_list [LAMBDA O (X Y)] [X COLLECTION] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(merge_to_list [LAMBDA O (X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(merge_to_set [LAMBDA O (X Y)] [X COLLECTION] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(merge_to_set [LAMBDA O (X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
Merges two collections into either a list or a set. This version of merging
only continues as long as both collections have elements. Thus, extra elements
in either list are ignored.  Extra parameters for the lambda function can be
passed as extra parameters of the call. Note that the variable shorthand cannot
be used for those extra parameters.


### SAFE-MERGE COLLECTIONS
{{< fatecode >}}(safe_merge_to_list [LAMBDA O (X Y)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(safe_merge_to_list [LAMBDA O (X Y Z0 ... ZN)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(safe_merge_to_set [LAMBDA O (X Y)] [X COLLECTION] [X COMPUTATION*] [Y COLLECTION] [Y COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(safe_merge_to_set [LAMBDA O (X Y Z0 ... ZN)] [X COLLECTION] [X COMPUTATION*] [Y COLLECTION] [Y COMPUTATION*] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
Merges two collections into either a list or a set. This version of merging
continues as long as either collection has elements. Hence the extra two
parameters compared to the non-safe version: these correspond to the value used
for the lambda when a collection has ran out of elements but the other has not.
Extra parameters for the lambda function can be passed as extra parameters of
the call. Note that the variable shorthand cannot be used for those extra
parameters.

### MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(indexed_merge_to_list [LAMBDA O (INT X Y)] [X COLLECTION] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(indexed_merge_to_list [LAMBDA O (INT X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(indexed_merge_to_set [LAMBDA O (INT X Y)] [X COLLECTION] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(indexed_merge_to_set [LAMBDA O (INT X Y Z0 ... ZN)] [X COLLECTION] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
Merges two collections into either a list or a set, indicating the index of both
elements as first parameter for the lambda function. This version of merging
only continues as long as both collections have elements. Thus, extra elements
in either list are ignored and there is only one index passed as parameter for
the lambda function. Extra parameters for the lambda function can be
passed as extra parameters of the call. Note that the variable shorthand cannot
be used for those extra parameters.

### SAFE-MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(safe_indexed_merge_to_list [LAMBDA O (INT X INT Y)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(safe_indexed_merge_to_list [LAMBDA O (INT X INT Y Z0 ... ZN)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
{{< fatecode >}}(safe_indexed_merge_to_set [LAMBDA O (INT X INT Y)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION]){{< /fatecode >}}
{{< fatecode >}}(safe_indexed_merge_to_set [LAMBDA O (INT X INT Y Z0 ... ZN)] [X COMPUTATION*] [X COLLECTION] [Y COMPUTATION*] [Y COLLECTION] [Z0 COMPUTATION*] ... [ZN COMPUTATION*]){{< /fatecode >}}
Merges two collections into either a list or a set. This version of merging
continues as long as either collection has elements. Hence the extra two
parameters compared to the non-safe version: these correspond to the value used
for the lambda when a collection has ran out of elements but the other has not.
This is also the reason why two indices are given. The index given for a list
that has ran out of elements is equal the size of the list.
Extra parameters for the lambda function can be passed as extra parameters of
the call. Note that the variable shorthand cannot be used for those extra
parameters.
