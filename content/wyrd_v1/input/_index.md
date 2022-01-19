---
menuTitle: <Input>
title: Input
weight: 6
---

Following an `<Instruction>` having set the `<State>`'s
`last_instruction_effect` to
`(MUST_PROMPT_COMMAND <IntValue> <IntValue> <TextValue>)`,
`(MUST_PROMPT_INTEGER <IntValue> <IntValue> <TextValue>)`,
`(MUST_PROMPT_FLOAT <FloatValue> <FloatValue> <TextValue>)`,
`(MUST_PROMPT_STRING <IntValue> <IntValue> <TextValue>)`,
or `(MUST_INPUT_CHOICE)`, it is necessary
for the user to provide an input prior to further `<Instruction>`s being
executed.  The information provided in the `<InstructionResult>` is expected
to be sufficient for the interpreter to ensure the user input is valid.
Providing invalid inputs to the `<State>` will result in undefined (and most
likely problematic) behaviors.

Thus, the `<State>` should expect to accept the following types of inputs:
### An `{Integer}` prompt answer
This follows a
`(MUST_PROMPT_INTEGER <IntValue> <IntValue> <TextValue>)`
`<InstructionResult>`.
* Interpret the `<State>`'s `memorized_target` as a
   `<PointerValue>` address.
* Update the `<Value>` pointed to by this address in the `<State>`'s memory
   so that it becomes an `<IntValue>` corresponding to the user's input.
* Set the `<State>`'s `last_instruction_effect` to `(MUST_CONTINUE)`.
* Proceed with the execution.

### A `{Float}` prompt answer
This follows a
`(MUST_PROMPT_FLOAT <FloatValue> <FloatValue> <TextValue>)`
`<InstructionResult>`.
* Interpret the `<State>`'s `memorized_target` as a
   `<PointerValue>` address.
* Update the `<Value>` pointed to by this address in the `<State>`'s memory
   so that it becomes an `<FloatValue>` corresponding to the user's input.
* Set the `<State>`'s `last_instruction_effect` to `(MUST_CONTINUE)`.
* Proceed with the execution.

### A `{String}` prompt answer
This follows a
`(MUST_PROMPT_STRING <IntValue> <IntValue> <TextValue>)`
`<InstructionResult>`.
* Interpret the `<State>`'s `memorized_target` as a
   `<PointerValue>` address.
* Update the `<Value>` pointed to by this address in the `<State>`'s memory
   so that it becomes an `<StringValue>` corresponding to the user's input.
* Set the `<State>`'s `last_instruction_effect` to `(MUST_CONTINUE)`.
* Proceed with the execution.

### A `{{String} List}` prompt answer
This follows a
`(MUST_PROMPT_COMMAND <IntValue> <IntValue> <TextValue>)` `<InstructionResult>`.
* Interpret the `<State>`'s `memorized_target` as a
   `<PointerValue>` address.
* Convert the user input to a `<ListValue>`: For each element of value
`{s: String}` and index `{i: Integer}`, the `<ListValue>` contains
`{{c_i: String} -> <c_s: StringValue>}` where `c_i` is a `{String}`
corresponding to `i` and `c_s` a `<StringValue>` corresponding to `s`.
* Update the `<Value>` pointed to by this address in the `<State>`'s memory
   so that it becomes the aforementioned `<ListValue>`.
* Set the `<State>`'s `last_instruction_effect` to `(MUST_CONTINUE)`.
* Proceed with the execution.

### An `{Integer}` choice answer
This follows a `(MUST_INPUT_CHOICE)` `<InstructionResult>`.
* Set the `<State>`'s `last_choice_index` to the input `{Integer}`.
* Empty the `<State>`'s `available_options` list.
* Set the `<State>`'s `last_instruction_effect` to `(MUST_CONTINUE)`.
* Proceed with the execution.
