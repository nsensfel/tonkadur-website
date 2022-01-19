---
menuTitle: <InstructionResult>
title: Instruction Result
weight: 5
---
Following the execution of an `<Instruction>`, the `<State>` will see its
`last_instruction_effect` be set to one of the following values:

* `(MUST_CONTINUE)`, indicating that the next `<Instruction>` should be
  executed.
* `(MUST_END)`, indicating that the story has ended. No further `<Instruction>`s
   should be executed.
* `(MUST_PROMPT_COMMAND <min: IntValue> <max: IntValue> <msg: TextValue>)`,
   indicating that an input should be given before executing further
   `<Instruction>`s. In this case, the execution should be done only after the
   user has seen `msg` and input a command (space separated list of strings)
   totaling between `min` and `max` characters (spaces included).
* `(MUST_PROMPT_FLOAT <min: FloatValue> <max: FloatValue> <msg: TextValue>))`,
   indicating that an input should be given before executing further
   `<Instruction>`s. In this case, the execution should be done only after the
   user has seen `msg` and input a float value included between `min` and `max`.
* `(MUST_PROMPT_INTEGER <min: IntValue> <max: IntValue> <msg: TextValue>))`,
   indicating that an input should be given before executing further
   `<Instruction>`s. In this case, the execution should be done only after the
   user has seen `msg` and input an integer value included between `min` and
   `max`.
* `(MUST_PROMPT_STRING <min: IntValue> <max: IntValue> <msg: TextValue>)`
   indicating that an input should be given before executing further
   `<Instruction>`s. In this case, the execution should be done only after the
   user has seen `msg` and input a string totaling between `min` and `max`
   characters.
* `(MUST_PROMPT_CHOICE)`
   indicating that an input should be given before executing further
   `<Instruction>`s. In this case, the execution should be done only after the
   user has chosen an option between the ones listed in the `<State>`'s
   `available_options`.
* `(MUST_DISPLAY <msg: TextValue>)`, indicating that `msg` should be displayed
   before further `<Instruction>`s are executed.
* `(MUST_DISPLAY_ERROR <msg: TextValue>)`, indicating that `msg` should be
   displayed as an error message before further `<Instruction>`s are executed.
