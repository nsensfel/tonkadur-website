---
menuTitle: <State>
title: State
weight: 1
---
* `memory: {{String} -> <Value>}`, which is pretty self-explanatory.
* `user_types: {{String} -> <Value>}`, providing the default value for each
   user-defined type.
* `sequences: {{String} -> {Int}}`, an optional member that gives you the value
   to give `program_counter` in order to jump to a certain sequence (untested).
* `code: {{Int} -> <Instruction>}`, to retrieve the `<Instruction>`
   corresponding to a line.
* `program_counter: {Int}`, the line of the next `<Instruction>` to be executed.
* `last_choice_index: {Int}`, the index (starting from 0) corresponding to the
   `<Option>` chosen by the user following a `(resolve_choice!)`.
* `available_options: {<Option> List}`, the list of `<Option>`s to present to
   the user upon encountering a `(resolve_choice!)`.
* `memorized_target: <Value>`, the address in which to store the next user
   input.
* `last_instruction_effect: <InstructionEffect>`, the result of the last
   executed `<Instruction>`. Developers may choose to keep it separate from the
   `<State>` structure if it makes more sense to do so in their chosen language
   (e.g. languages allowing functions with multiple returned values).

In order to manage unique address allocation, the proposed solution is to
include the following members. There is no issue with employing other solutions,
when more appropriate:
* `allocated_data: {Int}`, a value that has not been used to generate any
   allocable `<Address>`es before.
* `freed_addresses: {{String} Collection}`, a collection of freed allocable
   `<Address>`es, so that they may be re-used.

Lastly, randomness management might call for an additional member, depending on
the language:
* `random_seed: {RandomSeed}`, the next randomness seed to be used.

### Note on `memory`
One will notice that `memory` is `{{String} -> <Value>}`, yet addresses are
converted to `{{String} List}` before use. This is because some `<Value>`s
returned by `memory` can also be converted to `{{String} -> <Value>}` (see
`<ListValue>` and `<StructureValue>` on [this page](/wyrd_v1/value)). As a
result, the list is used to traverse/update these.

It is likely that you will want to treat the last element of the address
differently from the rest, as its parent would be the `{{String} -> Value}`
construction to consult or modify.
