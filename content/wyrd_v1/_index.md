---
menuTitle: Wyrd
title: Wyrd (Version 1)
---
Wyrd is the language in which the narrative is given to the game engine. It is
purposefully kept small and simple to facilitate porting Tonkadur to a new
engine.

The memory is seen as a table mapping strings to values. These values may also
be tables. Thus a reference is a list of strings corresponding to a move from
one table to the next.

The program is a list of instructions. These instructions may use computations
as parameters. They sometimes use hard-coded strings parameters as well.
Instructions cannot take instructions as parameters. Instructions are not
associated to any value.

An integer, called _Program Counter_ is used to indicate the current
instruction. In most cases, this integer is incremented by one after every
instruction. There is an instruction to modify the value of the Program Counter,
which allows conditional jumps and loops to be described.

Computations are values and operations returning values. These are solely used
as parameters of instructions. They do not alter memory (with one exception)
and do not interact with the Program Counter in any way. An execution cannot be
stopped during the evaluation of a computation: it is part of its parent
instruction and is thus completed exactly when that instruction is performed.
Computations may _read_ from the memory, as they may need to fetch the value
associated with an address or traverse tables. All computations have a return
type.

Wyrd does not have the notion of sequence or that lambda functions. It does not
even associate player choices with lists of actions. It's all done by carefully
managing the Program Counter.

Lambda functions are stored as an `INT` corresponding to a line in the program.

## Types
* `ADDRESS` (or `POINTER`, or `REFERENCE`), a list of `STRING` (note: not a
   `STRING COLLECTION`).
* `BOOL`. This should be changed to `BOOL` soon, for consistency's sake.
* `[SOMETHING] COLLECTION`, table mapping `STRING` to `[SOMETHING]`.
* `FLOAT`.
* `INT`.
* `RICH TEXT`, a list of `STRINGS` with attributes attached.
* `STRING`.
* `STRUCTURE` (or `DICTIONARY`), table mapping `STRING` to values of any type.
* `{String}`, a hard-coded string.

#### Aliases sometimes used to refer to types
* `? ADDRESS`: an `ADDRESS` pointing to a particular type.
* `BASE TYPE`: `INT`, `FLOAT`, `BOOL`, `STRING`.
* `COMPARABLE`: `INT`, `FLOAT`, `BOOL`, `STRING`, `RICH TEXT`, `ADDRESS`.
* `COLLECTION`: any `? COLLECTION`.
* `COMPUTATION`: any type.
* `NUMBER`: `INT` or `FLOAT`.
