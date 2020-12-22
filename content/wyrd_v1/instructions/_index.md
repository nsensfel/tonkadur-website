---
title: Instructions
weight: 2
---
This page presents all the instructions that can be performed in Wyrd.
Instructions do not return values. With one exception, all instructions increase
the Program Counter by 1.


## ADD CHOICE
{{< fatecode >}}(add_choice [RICH TEXT]){{< /fatecode >}}
Adds a new option for the next `resolve_choices` instruction. The new option
presents the player with `[RICH TEXT]`.

## INTEGER PROMPT
{{< fatecode >}}(prompt_integer [INT REFERENCE] [MIN = INT] [MAX = INT] [RICH TEXT]){{< /fatecode >}}

Prompts the user for an integer between `[MIN]` and `[MAX]` by displaying the
message `[RICH TEXT]`. The result is stored in `[INT REFERENCE]`.

## STRING PROMPT
{{< fatecode >}}(prompt_string [STRING REFERENCE] [MIN = INT] [MAX = INT] [RICH TEXT]){{< /fatecode >}}

Prompts the user for a string of size between `[MIN]` and `[MAX]` by displaying
the message `[RICH TEXT]`. The result is stored in `[STRING REFERENCE]`.


## ASSERT
{{< fatecode >}}(assert [BOOL] [RICH TEXT]){{< /fatecode >}}
If `[BOOL]` isn't _true_, raise a runtime error containing `[RICH TEXT]`.


## DISPLAY
{{< fatecode >}}(display [RICH TEXT]){{< /fatecode >}}
Displays `[RICH TEXT]` to the player.


## END
{{< fatecode >}}(end){{< /fatecode >}}
Marks the end of the narration. Interrupts the execution.


## EVENT CALL
{{< fatecode >}}(event_call {string} [C0 = COMPUTATION] ... [CN = COMPUTATION]){{< /fatecode >}}
Interrupts execution, informs the interpreter that the given event `{String}`
was triggered with the parameters `C0 ... CN`.


## REMOVE
{{< fatecode >}}(remove [ADDRESS]){{< /fatecode >}}
The memory at `[ADDRESS]` is freed.


## RESOLVE CHOICES
{{< fatecode >}}(resolve_choices){{< /fatecode >}}
Present the player with all options that where added using `add_choice` since
the last `resolve_choices`. The execution is paused and should be resumed by
the interpreter setting the Program Counter according to the chosen option.


## SET PC
{{< fatecode >}}(set_pc [INT]){{< /fatecode >}}
Sets the Program Counter to `[INT]`. The program counter is not automatically
increased by 1 in this case.


## SET VALUE
{{< fatecode >}}(set_value [ADDRESS] [COMPUTATION]){{< /fatecode >}}
Sets the memory pointed by `[ADDRESS]` to `[COMPUTATION]`.
`[COMPUTATION]` is passed by value, not reference (i.e. no aliasing can occur
without it being done explicitly through pointers).

## INITIALIZE MEMORY ELEMENT
{{< fatecode >}}(initialize [ADDRESS] [TYPE]){{< /fatecode >}}
Initializes a memory element at `[ADDRESS]` with the default value for the type
`[TYPE]`.
