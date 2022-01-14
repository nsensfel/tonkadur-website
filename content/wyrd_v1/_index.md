---
menuTitle: Wyrd Interpreter
title: Coding a Wyrd (Version 1) Interpreter
weight: 4
---
Wyrd is the language in which the narrative is given to the game engine. It is
purposefully kept small and simple to facilitate porting Tonkadur to a new
engine.

This part of the website guides you through the implementation of a Wyrd
interpreter.

Wyrd files are meant to use easily parsable formats. Tonkadur provides Wyrd
files as JSON, since JSON parsers are commonly available in pretty much any
general programming language. However, the code generating this output is
cleanly separated from the rest of the compiler, so changing the compiler to
output in a different format should be approachable.

As with Fate, Wyrd is split into computations and instructions. As a
reminder, computations do not modify the memory, whereas instructions may.
Furthermore, a computation in Fate may actually result in instructions in
Wyrd (a notable example being the `random` Fate computation, which is actually
implemented using the `set_random` Wyrd instruction).

Here is an overview of the Wyrd interpreter:
{{< svg "static/images/wyrd_interpreter_overview.svg" "1000px" >}}

The state a Wyrd story is described by `<State>`, a structure defined on [this
page](/wyrd_v1/state).

* `execute(<State>)` executes the next `<Instruction>` and returns the updated
   `<State>`. The semantics of each `<Instruction>` is explained on [this
   page](/wyrd_v1/instruction). Their effect on the `{User Interface}` is
   communicated by a `<InstructionResult>` member of `<State>`, but this it can
   alternatively be returned alongside the updated `<State>` if the
   implementation language permits it. All possible such effects are described
   on [this page](/wyrd_v1/instruction_result).
* Calls to `compute(<State>, <Computation>)` come from two sources: resolving
  the parameters of an `<Instruction>` and resolving the parameters of
  `<Computation>` (recursive call). The semantics of each `<Computation>` is
  defined on [this page](/wyrd_v1/computation) and is computed according to
  current `<State>` (they do not, however, modify it). The result is given as a
  `<Value>`, the semantics of which can be found on [this page](/wyrd_v1/value).
* The user may be called to provide an `<Input>`. This is presented by
  `handle_input(<Input>, <State>)` on the figure above. The different
  `<Input>`s and how to handle them are described on [this
  page](/wyrd_v1/input).
* The parsing process (`parse(<File>)`) is described on [this
  page](/wyrd_v1/file).
