---
title: "Notations"
menuTitle: "Notations"
weight: 1
---

This page explains the notations used on this documentation, as well as some
basics of Fate syntax.

Fate uses a LISP inspired syntax, meaning that parentheses have a special
importance and that everything uses a prefix notation. Basically, everything
follows a `(O A B C D)` form, where `O` is being applied to `A`, `B`, `C`, and
`D`.

Valid separators are spaces, tabs, and line returns. Having multiple separators
between two elements is the same as having a single one.

### Comments
Comments are line without anything but any number of separators before `;;`.
Every that follows the `;;` on that line is considered to be a comment.
{{< fatecode >}};; You can comment here
(fate_version 1)
     ;; Separators before the ';;' are also okay.
something ;; This is not a comment, since the line contains something else.
;; Multi line
;; comments need a ';;' on
;; every line.
(end)
{{< /fatecode >}}

### Literals
A literal is a hard-coded string. Basically, writing `42` corresponds to a
literal of value `42`. A literal is any non-empty hard-coded string not
containing a separator, nor any parentheses.

This documentation uses `{` and `}` to denote literal values.

Fate is pretty strict with typing, so literals have to have a type. The rule is
as follows: does Java parses the literal as an integer? If so, it's an `{INT}`;
otherwise, if it parses as a float? If so, it's a `{FLOAT}`; otherwise, it's a
`{STRING}`.

Now, the rules about separators and parentheses being absent in literals is a
bit problematic for strings. To remedy this:
* Writing `(lp)` counts as writing the literal `(`.
* Writing `(rp)` counts as writing the literal `)`.
* Writing `(sp)` counts as writing the literal ` ` (space).

Thus, you cannot write:
{{< fatecode >}}This is not valid (because of parentheses).{{< /fatecode >}}

But you can write:
{{< fatecode >}}This is valid (lp)because of parentheses(rp).{{< /fatecode >}}
And it will be a bunch of `{STRING}` literals.

### Identifier
`{IDENTIFIER}`: Non-empty string literal without space characters, `.`, `)`,
or `(`.  Line returns and tabs are considered to be space characters. Strings
that correspond to valid numbers (e.g. `42`) are likely to cause issues and
should thus be avoided.

Examples of valid identifiers:
* {{< fatecode >}}i{{< /fatecode >}}
* {{< fatecode >}}what-kind_ofMonsterIS#THIS?{{< /fatecode >}}
* {{< fatecode >}}変数{{< /fatecode >}}
* {{< fatecode >}}80x9!{{< /fatecode >}}
* {{< fatecode >}}pseudo::namespacing<$confusion>**a**{{< /fatecode >}}


### Value
`[INT]`: Computation (or literal) returning a value of type `INT`. Similarly,
`[STRING]` would indicate the same for a value of type `STRING`.

`[COMPUTATION]`: Any computation, the accepted type being determined by
something else.

Variable names can be used directly when a computation is expected. Since this
would cause issues when `[STRING]` values can also be used, this feature is not
always available. Cases where this feature is not available are suffixed with
a `*`. For example, `[COMPUTATION*]` means that writing `my_var` is interpreted
as the `[STRING]` literal `my_var`, and to get the value of a variable, you
would need to write something like `(var my_var)`. `[STRING]` automatically
implies `[STRING*]`.

If need be, `(string {STRING})`

Examples of valid value:
* Values for `[INT]`:
   * {{< fatecode >}}42{{< /fatecode >}}
   * {{< fatecode >}}(+ 2 100 11 0 3 9){{< /fatecode >}}
   * {{< fatecode >}}my_int_var{{< /fatecode >}}
* Values for `[STRING]`:
   * {{< fatecode >}}(string 42){{< /fatecode >}}
   * {{< fatecode >}}Just some random words...{{< /fatecode >}}
   * {{< fatecode >}}not_my_var{{< /fatecode >}}
   * {{< fatecode >}}(var my_string_var){{< /fatecode >}}

### Disambiguation and variadic operators
In Fate, the computation to obtain a random integer is as follows:
{{< fatecode >}}(rand [INT] [INT]){{< /fatecode >}}
This notation makes it difficult to document what each `[INT]` corresponds to.
To remedy this, names are given to each instance:
{{< fatecode >}}(rand [I0 = INT] [I1 = INT]){{< /fatecode >}}
Now, `[I0]` refers to the first `[INT]` value, and `[I1]` to the second one.

Some operators can take a variable number of parameters. For example, the
documentation for the logical conjunction computation is:
{{< fatecode >}}(and [B0 = BOOL] ... [BN = BOOL]){{< /fatecode >}}
The `...` indicate that there can be any number of instances of the type of parameter
that just preceded. In this example, `[B0 = BOOL] ...` indicates that there
can be any number of `[BOOL]` parameters. The parameter `[BN = BOOL]` is part
of the `...` notation and simply indicates that the documentation considers that
there are `N + 1` parameters. Thus, here, the documentation would allow:
* {{< fatecode >}}(and){{< /fatecode >}}
* {{< fatecode >}}(and (true)){{< /fatecode >}}
* {{< fatecode >}}(and (true) (false)){{< /fatecode >}}
* {{< fatecode >}}(and (true) (false) (false)){{< /fatecode >}}
* {{< fatecode >}}(and (true) (false) (false) (true)){{< /fatecode >}}
