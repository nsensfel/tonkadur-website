---
title: Collections
---
### ACCESS
{{< fatecode >}}(list:access [INT] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:access [INT] [SET]){{< /fatecode >}}

Returns the value of the `[INT]`th element in the collection.

### ACCESS CONSTANT INDEX
{{< fatecode >}}[(LIST) VAR].{Integer}{{< /fatecode >}}
{{< fatecode >}}[(SET) VAR].{Integer}{{< /fatecode >}}

Returns a variable corresponding to the `[INT]`th element in the collection.

### ADD ELEMENT AT
{{< fatecode >}}(list:add_element_at [INT] [COMPUTATION*] [LIST]){{< /fatecode >}}

Returns a copy of `[LIST]` with `[COMPUTATION*]` added at index `[INT]`. Note
that `[COMPUTATION*]` does not allow use of the variable shorthand if `[LIST]`
is a list of strings.

### ADD ELEMENT
{{< fatecode >}}(list:add_element [C0 = COMPUTATION*] ... [CN = COMPUTATION*] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:add_element [C0 = COMPUTATION*] ... [CN = COMPUTATION*] [SET]){{< /fatecode >}}

Returns a copy of `[COLLECTION]` with `C0` ... `CN` added. If `[COLLECTION]`
is a `[LIST]`, then the elements are added at the end of the list, in order
(meaning that `CN` will be the last element added).
Note that `[COMPUTATION*]` does not allow use of the variable shorthand if the
collection is a collection of strings.

### ADDING MEMBERS
{{< fatecode >}}(list:add_all_elements [C0 = LIST|SET]+ [C1 = LIST]){{< /fatecode >}}
{{< fatecode >}}(set:add_all_elements [C0 = LIST|SET]+ [C1 = SET]){{< /fatecode >}}

Returns a copy of `[C1]`, with all the elements of `[C0]` added. If `[C1]`
is a `[LIST]`, the new members are added at the end of the list.

As a shorthand, multiple `[C0]` can be specified. They will all be added in
order.

### SUB-LIST
{{< fatecode >}}(list:sublist [start: INT] [end_before: INT] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:subset [start: INT] [end_before: INT] [SET]){{< /fatecode >}}

Returns a copy of the collection in which only the elements with an index
higher or equal to `[start]` and strictly less than `[end_before]` are included.

### SHUFFLE
{{< fatecode >}}(list:shuffle [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:shuffle [SET]){{< /fatecode >}}

Returns a list containing all the elements of the collection in a random order.

### COUNT
{{< fatecode >}}(list:count [COMPUTATION*] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:count [COMPUTATION*] [SET]){{< /fatecode >}}

Returns the number of occurrences of `[COMPUTATION*]` in `[LIST]` or `[SET]`.
Note that `[COMPUTATION*]` does not allow use of the variable shorthand if
the collection is a collection of strings.

### INDEX OF
{{< fatecode >}}(list:index_of [COMPUTATION] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:index_of [COMPUTATION] [SET]){{< /fatecode >}}

Returns the index of the first occurrence of `[COMPUTATION]` in `[LIST]` or
`[SET]`, starting at 0.

### IS MEMBER
{{< fatecode >}}(list:is_member [COMPUTATION] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:is_member [COMPUTATION] [SET]){{< /fatecode >}}

Returns true if, and only if, `[COMPUTATION]` is in `[LIST]` or `[SET]`.

### SIZE
{{< fatecode >}}(list:size [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:size [SET]){{< /fatecode >}}

Returns the size (`[INT]`) of `[LIST]` or `[SET]`.

### IS EMPTY
{{< fatecode >}}(list:is_empty [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:is_empty [SET]){{< /fatecode >}}

Returns true if, and only if `[LIST]` or `[SET]` is empty.

### REMOVE ONE COPY
{{< fatecode >}}(list:remove [COMPUTATION*]+ [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:remove [COMPUTATION*]+ [SET]){{< /fatecode >}}

Returns a copy of the collection with one instance of `[COMPUTATION*]` having been removed. The variable shorthand cannot be used if the collection is a collection of strings.

As a shorthand, multiple computations can be specified. They will all be removed
in order.

### REMOVE ALL COPIES
{{< fatecode >}}(list:remove_each [COMPUTATION*]+ [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:remove_each [COMPUTATION*]+ [SET]){{< /fatecode >}}

Returns a copy of the collection with all instances of `[COMPUTATION*]` having been removed. The variable shorthand cannot be used if the collection is a collection of strings.

As a shorthand, multiple computations can be specified. They will all be removed
from the list.

### REMOVE ALL ALSO IN
{{< fatecode >}}(list:remove_all [removed: COLLECTION]+ [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:remove_all [removed: COLLECTION]+ [SET]){{< /fatecode >}}

Returns a copy of the collection with all elements of `[removed]` having been
removed.

As a shorthand, multiple `[removed]` can be specified. Their elements will all
be removed.

### REMOVE AT
{{< fatecode >}}(list:remove_at [INT] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:remove_at [INT] [SET]){{< /fatecode >}}

Returns a copy of the collection with the element at index `[INT]` having been
removed.

### PUSH ELEMENT
{{< fatecode >}}(list:push_left [COMPUTATION*] [LIST]){{< /fatecode >}}
{{< fatecode >}}(list:push_right [COMPUTATION*] [LIST]){{< /fatecode >}}
{{< fatecode >}}(set:push_left [COMPUTATION*] [SET]){{< /fatecode >}}
{{< fatecode >}}(set:push_right [COMPUTATION*] [SET]){{< /fatecode >}}

Returns a list corresponding to the given `[LIST]` or `[SET]` to which the
`[COMPUTATION*]` has been added to the right (`push_right`) or the left
(`push_left`).

### POP ELEMENT
TODO

### PARTITION
TODO

### PARTITION (INDEXED)
TODO

### SORT
TODO

### FILTER ELEMENTS
{{< fatecode >}}(list:filter [LAMBDA BOOL (X)] [X LIST]){{< /fatecode >}}
{{< fatecode >}}(set:filter [LAMBDA BOOL (X)] [X SET]){{< /fatecode >}}

Returns a copy of `[X LIST]` or `[X SET]` in which only the elements for which
`[LAMBDA BOOL (X)]` returns `true` remain.

### FILTER ELEMENTS (INDEXED)
{{< fatecode >}}(list:indexed_filter [LAMBDA BOOL (INT X)] [X LIST]){{< /fatecode >}}
{{< fatecode >}}(set:indexed_filter [LAMBDA BOOL (INT X)] [X SET]){{< /fatecode >}}

Returns a copy of `[X LIST]` or `[X SET]` in which only the elements for which
`[LAMBDA BOOL (INT X)]` (with `INT` being the element's index) returns `true`
remain.

### FOLD OVER COLLECTION
{{< fatecode >}}(list:foldl [LAMBDA X (X Y)] [X COMPUTATION*] [Y LIST]){{< /fatecode >}}
{{< fatecode >}}(list:foldr [LAMBDA X (X Y)] [X COMPUTATION*] [Y LIST]){{< /fatecode >}}
{{< fatecode >}}(set:foldl [LAMBDA X (X Y)] [X COMPUTATION*] [Y SET]){{< /fatecode >}}
{{< fatecode >}}(set:foldr [LAMBDA X (X Y)] [X COMPUTATION*] [Y SET]){{< /fatecode >}}

Returns the result of iterating `[LAMBDA X (X Y)]` over `[Y COLLECTION]`, with
`[X COMPUTATION*]` being the initial value. The direction of the iteration is
by ascending index order when using `foldl`, and the opposite order when using
`foldr`. The variable shorthand cannot be used for the initial value if the
lambda function returns a string.

### MERGE COLLECTIONS
{{< fatecode >}}(list:merge [LAMBDA O (X Y)] [X LIST|X SET] [Y LIST|Y SET]){{< /fatecode >}}
{{< fatecode >}}(set:merge [LAMBDA O (X Y)] [X LIST|X SET] [Y LIST|Y SET]){{< /fatecode >}}
Merges two collections into either a list (`list:merge`) or a set
(`set:merge`). This version of merging only continues as long as both
collections have elements. Thus, extra elements in either list are ignored.


### SAFE-MERGE COLLECTIONS
{{< fatecode >}}(list:safe_merge [LAMBDA O (X Y)] [X LIST|X SET] [X COMPUTATION] [Y LIST|Y SET] [Y COMPUTATION]){{< /fatecode >}}
{{< fatecode >}}(set:safe_merge [LAMBDA O (X Y)] [X LIST|X SET] [X COMPUTATION] [Y LIST|Y SET] [Y COMPUTATION]){{< /fatecode >}}
Safely merges two collections into either a list (`list:safe_merge`) or a set
(`set:safe_merge`). This version of merging continues as long as either
collection has elements. If one of the two collections runs out of elements
before the other, it uses the provided default value (`[X COMPUTATION]` for the
first list, `[Y COMPUTATION]` for the second one).

### MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(list:indexed_merge [LAMBDA O (INT X Y)] [X LIST|X SET] [Y LIST|Y SET]){{< /fatecode >}}
{{< fatecode >}}(set:indexed_merge [LAMBDA O (INT X Y)] [X LIST|X SET] [Y LIST|Y SET]){{< /fatecode >}}
Merges two collections into either a list (`list:merge`) or a set
(`set:merge`). This version of merging only continues as long as both
collections have elements. Thus, extra elements in either list are ignored.
The first parameter passed to the lambda function is the index of the element
in both collections.

### SAFE-MERGE COLLECTIONS (INDEXED)
{{< fatecode >}}(list:indexed_safe_merge [LAMBDA O (INT X INT Y)] [X LIST|X SET] [X COMPUTATION] [Y LIST|Y SET] [Y COMPUTATION]){{< /fatecode >}}
{{< fatecode >}}(set:indexed_safe_merge [LAMBDA O (INT X INT Y)] [X LIST|X SET] [X COMPUTATION] [Y LIST|Y SET] [Y COMPUTATION]){{< /fatecode >}}
Safely merges two collections into either a list (`list:safe_merge`) or a set
(`set:safe_merge`). This version of merging continues as long as either
collection has elements. If one of the two collections runs out of elements
before the other, it uses the provided default value (`[X COMPUTATION]` for the
first list, `[Y COMPUTATION]` for the second one). The first and third parameters
passed to the lambda function correspond to the index of the element in either
collection. It does not increase if the collection has no more elements and is
using the default value.
