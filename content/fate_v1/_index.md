---
title: "Fate (Version 1)"
menuTitle: "Fate"
weight: 3
---

When using Tonkadur, Fate is the language the author writes in. This language is
meant to provide the writer with as many tools as possible, so that they do not
feel constrained by the limitations of the language, nor find writing complex
narratives tedious.

To write in Fate, simply open your favorite text editor and create a new file
that starts with the following line:
{{< fatecode >}}(fate_version 1){{< /fatecode >}}

Before going any further into the documentation, you should familiarize yourself
with the [notations](/fate_v1/notations/).

Fate files are composed of three types of constructs:
* [Computations](/fate_v1/computations/), operations that do not modify the
  memory and return a value.
* [Instructions](/fate_v1/instructions/), constructs that can modify the memory
  but do not return any values.
* [Declarations](/fate_v1/declarations/), special instructions that are
  performed during compilation instead of during the execution.

Other concepts in Fate include:
* [Variables](/fate_v1/declarations/variables/): named memory element.
* [Types](/fate_v1/declarations/types/): every memory element is assigned a
  specific type. Fate uses static and strong typing, meaning that types are
  determined at compilation time and typing
* [Procedures/Sequences](/fate_v1/declarations/sequences/): named list of
  instructions, which can take parameters.
* [Lambda Functions](/fate_v1/computations/lambda_functions/): computations
  which are not performed immediately but are instead stored for future use.
* [Addresses/Pointers](/fate_v1/computations/addresses/): value that
  corresponds to a memory element (not to be confused with the value *of* that
  memory element).
* Conditionals: selection of
  [computations](/fate_v1/computations/conditionals/) or
  [instructions](/fate_v1/instructions/conditionals/) depending on a
  computation.
* [Loops](/fate_v1/instructions/loops/): repetition of instructions controlled
  by computations.
* [Choices](/fate_v1/instructions/player_choices/): prompt the user to select an
  option.
