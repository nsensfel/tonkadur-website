---
title: Player Choices
---
Player choices are the main way to interact with the user, by presenting them
with a list of `[RICH TEXT]` choices, and executing a list of instructions
associated to the choice they have made.

### CHOICE OPTION
{{< fatecode >}}([TEXT] [I0 = INSTRUCTION] ... [IN = INSTRUCTION]){{< /fatecode >}}

Adds a choice showing `[RICH TEXT]` to the user, and executing `[I0]` ... `[IN]`
if chosen.

### CHOICE PROMPT
{{< fatecode >}}(player_choice [C0 = CHOICE] ... [C1 = CHOICE]){{< /fatecode >}}

Prompts the user to choose between `C0` ... `C1`. `[CHOICE]`. `[CHOICE]` is
either an option as shown above, a [conditional](../conditionals), or a
`for_each` (see [loops](../loops)) with `[CHOICE]` instead of `[INSTRUCTION]`.

### INTEGER PROMPT
{{< fatecode >}}(prompt_integer [INT REFERENCE] [MIN = INT] [MAX = INT] [TEXT]){{< /fatecode >}}

Prompts the user for an integer between `[MIN]` and `[MAX]` by displaying the
message `[TEXT]`. The result is stored in `[INT REFERENCE]`.

### STRING PROMPT
{{< fatecode >}}(prompt_string [STRING REFERENCE] [MIN = INT] [MAX = INT] [TEXT]){{< /fatecode >}}

Prompts the user for a string of size between `[MIN]` and `[MAX]` by displaying
the message `[TEXT]`. The result is stored in `[STRING REFERENCE]`.
