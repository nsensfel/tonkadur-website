---
title: Variables
weight: 3
---
Variables are what hold values. Each variable has a type, which cannot be
changed.

There are two variable scopes: local and global. A global variable can only be
declared outside of any sequence. A local variable can also be declared within a
sequence. Local variables can only be accessed within their context. In effect,
a local variable declared outside of a sequence cannot be accessed in any
sequence, and local variables cannot be accessed within lambda functions. Local
variables can override global variables within their context.

The sole exception to accessing a local variable outside its context is done
through the use of pointers. Local variables live as long as the context
that declared them does. Accessed one through a pointer past that point is
likely to result in a runtime error and is, in any case, not to be done.

Each sequence and lambda function defines its own context and thus does not
share local variable with the others. Instructions which themselves contain
instructions define hierarchies. Local variables defined within a hierarchical
level can be accessed in that level and inner level, but are not shared with
outer levels. For example:

{{< fatecode >}}(if_else (var my_test)
   (
      (local int my_var) ;; my_var (a)
      (set my_var 32)
   )
   (
      ;; my_var (a) is not defined here.
      (local int my_var) ;; my_var (b)
      (set my_var 42)
      (if (var my_other_test)
         (
            (local int my_other_var)
            ;; Both my_other_var and my_var (b) are defined here
         )
      )
      ;; only my_var (b) is defined here
   )
)
{{< /fatecode >}}

Generic instruction lists do not generate a new level of hierarchy:

{{< fatecode >}}(
   (local int my_var)
)
;; my_var is still defined.
{{< /fatecode >}}

### LOCAL VARIABLE
{{< fatecode >}}(local [TYPE] {Identifier}){{< /fatecode >}}
Declares the local variable `{Identifier}` of type `[TYPE]`.

### GLOBAL VARIABLE
{{< fatecode >}}(global [TYPE] {Identifier}){{< /fatecode >}}
Declares the global variable `{Identifier}` of type `[TYPE]`.

### EXTERNAL VARIABLE
{{< fatecode >}}(external [TYPE] {Identifier}){{< /fatecode >}}
Declares the external variable `{Identifier}` of type `[TYPE]`.
External variables do not get initialized and are assumed to already have been
set prior to the narrative starting.

## Example
{{< fatecode >}}(local string name_of_dog)

(global (ptr int) index_of_result)

;; Here is an amusing use of variables:
(global int something_unexpected)
(local int something_unexpected)
;; something_unexpected will not be the same variable within processes (which
;; will use the global variable) and outside of them (which will use the local
;; variable). For code readability reasons, I do not recommend doing this.
{{< /fatecode >}}
