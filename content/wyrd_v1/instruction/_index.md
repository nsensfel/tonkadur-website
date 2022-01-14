---
menuTitle: <Instruction>
title: Instruction
weight: 2
---
This page presents all the `<Instruction>`s that can be performed in Wyrd.
`<Instruction>`s do not return values.

Unless otherwise specified, all `<Instruction>`s:
* Increment the `<State>`'s `program_counter` by 1.
* Set the `<State>`'s `last_instruction_result` to `(MUST_CONTINUE)`.

Implementing `execute(<State>)` to recurse/loop as long as the newly updated
`<State>`'s `last_instruction_result` is `(MUST_CONTINUE)` is acceptable.

**Shortcut to each `<Instruction>`:**
* [`(add_event_option! {name: String} {parameters: <Computation> List})`](#add_event_option)
* [`(add_text_option! <value: Computation>)`](#add_text_option)
* [`(assert! <condition: Computation> <message: Computation>)`](#assert)
* [`(display! <value: Computation>)`](#display)
* [`(end!)`](#end)
* [`(initialize! {type: String} <target: Computation>)`](#initialize)
* [`(prompt_command! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`](#prompt_command)
* [`(prompt_float! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`](#prompt_float)
* [`(prompt_integer! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`](#prompt_integer)
* [`(prompt_string! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`](#prompt_string)
* [`(remove! <target: Computation>)`](#remove)
* [`(resolve_choice!)`](#resolve_choice)
* [`(set_pc! <value: Computation>)`](#set_pc)
* [`(set_random! <min: Computation> <max: Computation> <target: Computation>)`](#set_random)
* [`(set_value! <target: Computation> <value: Computation>)`](#set_value)
* [`({extra_instruction: String}! {parameters: <Computation> List})`](#extra_instruction)

### add_event_option
`(add_event_option! {name: String} {parameters: <Computation> List})`

Adds an `<Option>` based on an `<Event>` for the user.

**Parameters:**
* `value` is a `{String}` indicating the name of the `<Event>`.
* `parameters` is a `{List}` of `<Computation>` that will yield the `<Value>`s
   required for this option to be chosen when the `<Event>` occurs on the next
   `(resolve_choice!)`.

**Process:**
* Compute the `<Value>` corresponding to each member of `parameters`, store them
   in a `{List}` while keeping the order.
* Create a new `<EventOption>` with name `name` and the aforementioned
  `{<Value> List}` as parameters.
* Append the newly created `<EventOption>` to the end of the `<State>`'s
  `available_options`.

### add_text_option
`(add_text_option! <value: Computation>)`

Adds an `<Option>` based on an `<TextValue>` for the user.

**Parameters:**
* `value` is a `<Computation>` that will yield the `<TextValue>` displayed to
   the user for this option on the next `(resolve_choice!)`.

**Process:**
* Compute the `<Value>` yielded by `value`.
* Create a new `<TextOption>` corresponding to the aforementioned
  `<Value>`.
* Append the newly created `<TextOption>` to the end of the `<State>`'s
  `available_options`.

### assert
`(assert! <condition: Computation> <message: Computation>)`

Checks if a condition is fulfilled and prints an error message if it is not.

**Parameters:**
* `condition` is a `<Computation>` corresponding to what needs to be tested.
* `message` is a `<Computation>` defining the error message displayed to the
   user if the condition is not verified.

**Process:**
* Compute the `<Value>` yielded by `condition`.
* Interpret this `<Value>` as `{Boolean}`.
* If it is `TRUE`, the `<Instruction>` has completed.
* Otherwise, compute the `<msg: Value>` corresponding to the `message`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_DISPLAY_ERROR <msg: Value>)`.

### display
`(display! <value: Computation>)`

Displays text to the user.

**Parameters:**
* `value` is a `<Computation>` corresponding to what has to be displayed.

**Process:**
* Compute the `<msg: Value>` corresponding to `value`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_DISPLAY <msg: Value>)`.

### end
`(end!)`

Ends the story.

**Process:**
* Do **not** increase the `<State>`'s `program_counter`.
* Set the `<State>`'s `last_instruction_result` to `(MUST_END)`

### initialize
`(initialize! {type: String} <target: Computation>)`

Adds an element to `memory` with a deterministic default value.

**Parameters:**
* `type` is a `{String}` corresponding to the type that will be used by
  `target`.
* `target` is `<Computation>` that will yield the address to initialize.

**Process:**
* Compute the `<Value>` resulting from `target`. This is a `<PointerValue>`.
* Interpret this `<PointerValue>` as a `{{String} List}`.
* Update the `<State>`'s `memory` so that the element pointed to by the
   `<PointerValue>` takes the default value for a `<Value>` of type `type`. Note
   that the `target` might point to an element that does not exist yet.

### prompt_command
`(prompt_command! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`

Asks the user to provide a list of strings as input.

**Parameters:**
* `min` is a `<Computation>` indicating the minimum size the user `{String}`
  input should be (in characters).
* `max` is a `<Computation>` indicating the maximum size the user `{String}`
  input should be (in characters).
* `target` is a `<Computation>` indicating where to store the result.
*  `message` is a `<Computation>` corresponding to the message displayed to the
   user for this prompt.

**Process:**
* Compute the `<Value>` corresponding to each of these parameter.
* Update the `<State>`'s `memorized_target` to be the `<Value>` resulting from
  `target`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_PROMPT_COMMAND <min_val: Value> <max_val: Value> <msg: Value>)`.

### prompt_float
`(prompt_float! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`

Asks the user to provide a float as input.

**Parameters:**
* `min` is a `<Computation>` indicating the minimum float the user is allowed
   to input
* `max` is a `<Computation>` indicating the maximum float the user is allowed
   to input
* `target` is a `<Computation>` indicating where to store the result.
*  `message` is a `<Computation>` corresponding to the message displayed to the
   user for this prompt.

**Process:**
* Compute the `<Value>` corresponding to each of these parameter.
* Update the `<State>`'s `memorized_target` to be the `<Value>` resulting from
  `target`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_PROMPT_FLOAT <min_val: Value> <max_val: Value> <msg: Value>)`.


### prompt_integer
`(prompt_integer! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`

Asks the user to provide an integer as input.

**Parameters:**
* `min` is a `<Computation>` indicating the minimum integer the user is allowed
   to input
* `max` is a `<Computation>` indicating the maximum integer the user is allowed
   to input
* `target` is a `<Computation>` indicating where to store the result.
*  `message` is a `<Computation>` corresponding to the message displayed to the
   user for this prompt.

**Process:**
* Compute the `<Value>` corresponding to each of these parameter.
* Update the `<State>`'s `memorized_target` to be the `<Value>` resulting from
  `target`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_PROMPT_INTEGER <min_val: Value> <max_val: Value> <msg: Value>)`.

### prompt_string
`(prompt_string! <min: Computation> <max: Computation> <target: Computation> <message: Computation>)`

Asks the user to provide a string as input.

**Parameters:**
* `min` is a `<Computation>` indicating the minimum size the user `{String}`
  input should be (in characters).
* `max` is a `<Computation>` indicating the maximum size the user `{String}`
  input should be (in characters).
* `target` is a `<Computation>` indicating where to store the result.
*  `message` is a `<Computation>` corresponding to the message displayed to the
   user for this prompt.

**Process:**
* Compute the `<Value>` corresponding to each of these parameter.
* Update the `<State>`'s `memorized_target` to be the `<Value>` resulting from
  `target`.
* Set the `<State>`'s `last_instruction_result` to
   `(MUST_PROMPT_STRING <min_val: Value> <max_val: Value> <msg: Value>)`.

### remove
`(remove! <target: Computation>)`

Removes an element from memory.

**Parameter:**
* `target` is a `<Computation>` indicating where the element to remove is.

**Process:**
* Compute the `<Value>` corresponding to `target`.
* Interpet this `<Value>` as an address.
* Remove the element at this address from the `<State>`'s `memory`.

### resolve_choice
`(resolve_choice!)`

Makes the user choose between all previously added options.

**Process:**
* Set the `<State>`'s `last_instruction_result` to `(MUST_PROMPT_CHOICE)`.


### set_pc
`(set_pc! <value: Computation>)`

Sets the program counter to a given value.

**Parameter:**
* `value` is a `<Computation>` indicating what to set the program counter to.

**Process:**
* Compute the `<Value>` for `value`.
* Interpret this `<Value>` as an `{Integer}`.
* Set the `<State>`'s `program_counter` to this value.
* Do **not** otherwise increase the `<State>`'s `program_counter`.

### set_random
`(set_random! <min: Computation> <max: Computation> <target: Computation>)`

Replaces the `<Value>` at a given address with a random integer. This is not
a computation as some languages will require state updates to keep generating
new random values.

**Parameters:**
* `min` is a `<Computation>` indicating the minimum integer allowed.
   to input
* `max` is a `<Computation>` indicating the maximum integer allowed.
* `target` is a `<Computation>` indicating where to store the result.

**Process:**
* Compute the `<Value>` corresponding to each of these parameter.
* Generate a random `{Integer}` between `min` and `max` (included).
* Update the `<State>`'s `memory`so that the element at `target` is to be the
  `<Value>` resulting from `target`.

### set_value
`(set_value! <target: Computation> <value: Computation>)`

Sets the value of an element in memory.

**Parameters:**
* `target` is a `<Computation>` indicating what element to set to the value.
* `value` is a `<Computation>` corresponding to the value to give the element.

**Process:**
* Compute `target` as `<addr: Value>`.
* Modify the `<State>`'s `memory` so that the element at `addr` takes the
   `<Value>` resulting from `value`'s computation.

### extra_instruction
`({extra_instruction: String}! {parameters: <Computation> List})`

Executes non-standard instruction.

**Parameters:**
* `extra_instruction` is the name of the extra instruction.
* `parameters` is a list of parameters for this instruction call.

**Process:**
* Undetermined. This is where you choose the process according to the value of
   `extra_instruction` so that you can add non-standard instructions.
