---
title: Collections
---
Fate supports two types of collections: `[LIST]`, which are basic, unordered
lists; and `[SET]`, which are ordered lists, but only useable with
`[COMPARABLE]` elements.

### ADDING A MEMBER
{{< fatecode >}}(list:add_element! [C0 = X COMPUTATION*] ... [CN = X COMPUTATION*] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:add_element! [C0 = X COMPUTATION*] ... [CN = X COMPUTATION*] [X SET REFERENCE]){{< /fatecode >}}

Adds `C0` ... `CN` to the `[X LIST]` or `[X SET]` collection reference. If the
collection is a `[LIST]`, the new members are added at the end of the list, in
order (meaning that the list then ends with `CN`). Note that `[COMPUTATION*]`
does not support use of the variable shorthand if this is a collection of
strings or text.

### ADDING A MEMBER AT INDEX
{{< fatecode >}}(list:add_element_at! [INT] [X COMPUTATION*] [X LIST REFERENCE]){{< /fatecode >}}

Adds `[COMPUTATION*]` to `[X LIST REFERENCE]` at index `[INT]`. If `[INT]` is
less than 0, the element is added at the start of the list, and if `[INT]` is
greater or equal to the size of the list, the element is added at the end of
the list. Note that `[COMPUTATION*]` does not support use of the variable
shorthand if this is a collection of string or text.

### ADDING MEMBERS
{{< fatecode >}}(list:add_all_elements! [X COLLECTION] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:add_all_elements! [X COLLECTION] [X SET REFERENCE]){{< /fatecode >}}

Adds all the elements of `[COLLECTION]` to the `[X LIST]` or `[X SET]`
collection reference. In the case of `[X LIST]`, the new members are added at
the end of the list.

### EMPTYING COLLECTIONS
{{< fatecode >}}(list:clear! [LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:clear! [SET REFERENCE]){{< /fatecode >}}

Removes all members of the `[LIST]` or `[SET]` collection reference.

### REMOVING MEMBER
{{< fatecode >}}(list:remove! [X COMPUTATION*] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:remove! [X COMPUTATION*] [X SET REFERENCE]){{< /fatecode >}}

Removes the first member of the `[X LIST]` or `[X SET]` collection reference
equal to `[COMPUTATION]`.  Note that `[COMPUTATION*]` does not support use of
the variable shorthand if this is a collection of string or text.

### REMOVING MEMBERS
{{< fatecode >}}(list:remove_all! [X COMPUTATION*] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:remove_all! [X COMPUTATION*] [X SET REFERENCE]){{< /fatecode >}}

Removes all values equal to `[COMPUTATION]` from the `[X LIST]` or `[X SET]`
collection reference.  Note that `[COMPUTATION*]` does not support use of the
variable shorthand if this is a collection of string or text.

### REMOVING AT INDEX
{{< fatecode >}}(list:remove_at! [INT] [LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:remove_at! [INT] [SET REFERENCE]){{< /fatecode >}}

Removes from the collection reference the element at index `[INT]`.

### REVERSING LISTS
{{< fatecode >}}(list:reverse! [LIST REFERENCE]){{< /fatecode >}}

Reverses the order of the members of `[LIST REFERENCE]`.

### FILTER ELEMENTS
{{< fatecode >}}(list:filter! [LAMBDA BOOL (X)] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:filter! [LAMBDA BOOL (X)] [X SET REFERENCE]){{< /fatecode >}}
Modifies the collection reference so that only the elements for which
`[LAMBDA BOOL (X)]` returns `true` remain.

### FILTER ELEMENTS (INDEXED)
{{< fatecode >}}(list:indexed_filter! [LAMBDA BOOL (INT X)] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:indexed_filter! [LAMBDA BOOL (INT X)] [X SET REFERENCE]){{< /fatecode >}}
Modifies the collection reference so that only the elements for which
`[LAMBDA BOOL (INT X)]` returns `true` remain, with the `[INT]` value being the
index of the element in the collection.

### SUBLIST
{{< fatecode >}}(list:sublist! [start_at = INT] [end_before = INT] [LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:sublist! [start_at = INT] [end_before = INT] [SET REFERENCE]){{< /fatecode >}}

Only keep in the collection reference the elements with indexes equal or
greater than `[start_at]` and strictly lower than `[end_before]`.

### SORT
{{< fatecode >}}(list:sort! [LAMBDA INT (X X)] [X LIST REFERENCE]){{< /fatecode >}}

Reorders the elements of the list reference according to the `[LAMBDA]`
function. The resulting order is ascending. To compare two elements, the lambda
function should return:
- a negative number if the first argument is lower than the second.
- zero if the first argument is equal to the second.
- a non-null positive number otherwise.

### SHUFFLE
{{< fatecode >}}(list:shuffle! [LIST REFERENCE]+){{< /fatecode >}}

Randomly changes the order of the elements in `[LIST REFERENCE]`. As a
shorthand, multiple calls to the `list:shuffle!` instruction can be merged by
passing more lists as arguments.

### PUSH ELEMENT
{{< fatecode >}}(list:push_right! [X COMPUTATION] [X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(list:push_left! [X COMPUTATION] [X LIST REFERENCE]){{< /fatecode >}}

Adds an element `[X]` at the start (`list:push_left`) or the end
(`list:push_right`) of a list reference.

### POP ELEMENT
{{< fatecode >}}(list:pop_right! [X LIST REFERENCE] [X REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(list:pop_left! [X LIST REFERENCE] [X REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:pop_right! [X SET REFERENCE] [X REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:pop_left! [X SET REFERENCE] [X REFERENCE]){{< /fatecode >}}


Removes and retrieves the element at the start (`pop_left`) or the end
(`pop_right`) of a list. The removed element is stored in `[X REFERENCE]`.

### PARTITION
{{< fatecode >}}(list:partition! [LAMBDA BOOL (X)] [if_true = X LIST REFERENCE] [if_false = X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:partition! [LAMBDA BOOL (X)] [if_true = X SET REFERENCE] [if_false = X SET REFERENCE]){{< /fatecode >}}

Partitions a collection reference `[if_true]`, leaving in the collection all elements
for which the lambda function returns `(true)` and moving to the collection reference
`[if_false]` all elements for which the lambda function returns `(false)`.

### PARTITION (INDEXED)
{{< fatecode >}}(list:partition! [LAMBDA BOOL (INT X)] [if_true = X LIST REFERENCE] [if_false = X LIST REFERENCE]){{< /fatecode >}}
{{< fatecode >}}(set:partition! [LAMBDA BOOL (INT X)] [if_true = X SET REFERENCE] [if_false = X SET REFERENCE]){{< /fatecode >}}

Partitions a collection reference `[if_true]`, leaving in the collection all elements
for which the lambda function returns `(true)` and moving to the collection reference
`[if_false]` all elements for which the lambda function returns `(false)`. The first
argument given to the lambda function corresponds to the index of the element in
the collection (prior to the partitioning).
