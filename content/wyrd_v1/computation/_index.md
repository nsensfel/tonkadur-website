---
menuTitle: <Computation>
title: Computation
weight: 3
---
This page presents all the `<Computation>`s that can be performed in Wyrd.
`<Computation>`s do not modify the memory, but they always return a `<Value>`.
Be careful not to modify the memory through reference when computing values.

**Shortcut to each `<Computation>`:**
* [`(add_text_effect {name: String} {parameters: <Computation> List} {values: <Computation> list})`](#add_text_effect)
* [`(address <value_or_target: Computation>)`](#address)
* [`(cast {from: String} {to: String} <content: Computation>)`](#cast)
* [`(constant {type: String} {value: String})`](#constant)
* [`(get_allocable_address)`](#get_allocable_address)
* [`(if_else <condition: Computation> <if_true: Computation> <if_false: Computation>)`](#if_else)
* [`(last_choice_index)`](#last_choice_index)
* [`(newline)`](#newline)
* [`(operation {operator: String} <x: Computation>)`](#unary-operation)
* [`(operation {operator: String} <x: Computation> <y: Computation>)`](#operation)
* [`(relative_address <target: Computation> <extra: Computation>)`](#relative_address)
* [`(size <target: Computation>)`](#target)
* [`(text {values: <Computation> List})`](#text)
* [`(value_of <target: Computation>)`](#value_of)
* [`({extra_computation} {parameters: <Computation> List})`](#extra_computation)

### add_text_effect
`(add_text_effect {name: String} {parameters: <Computation> List} {values: <Computation> list})`

Add an effect to a list of texts, returning it as a single text.

**Parameters:**
* `name` is a `{String}` indicating the name of the effect.
* `parameters` is a `{List}` of `<Computation>` that will yield the `<Value>`s
   used as parameters for the effect.
* `values` is a `{<Computation> List}` that will yield the texts to merge and
   apply the effect to. These will yield `<TextValue>`s.

**Process:**
* Compute the `{params: <Value> List}` corresponding to `parameters` (keep the
   order).
* Compute the `{texts: <Value> List}` corresponding to `values` (keep the
   order).
* Return a new `<AugmentedText>` `<TextValue>` with `texts` as `content`,
   `name` as `effect_name`, and `params` as `effect_parameters`.

### address
`(address <value_or_target: Computation>)`

Converts to an address.

**Parameters:**
* `value_or_target` is a `<Computation>` that will either result in in a
   `<PointerValue>` or a `<StringValue>`.

**Process:**
* Compute the `<Value>` corresponding to `value_or_target`.
* If this resulted in a `<PointerValue>`, return the value as is.
* If this resulted in a `<StringValue>`, interpret the value as
   `{addr: String}`, return a new `<PointerValue>` built from a singleton list
   with `addr` as its only element.

### cast
`(cast {from: String} {to: String} <content: Computation>)`

Convert from one type to another.

**Parameters:**
* `from` is a `{String}` naming the type `content` will result to.
* `to` is a `{String}` naming the type to convert `content` to.
* `content` is a `<Computation>` that will yield the `<Value>` to convert.

**Process:**
* Compute the `<Value>` associate with `content`.
* Convert this `<Value>` from `from` to `to`.
* Return the converted value.

**Note:**
The following conversions are expected to be available:
* A type to the same type, returning the same value.
* `<BoolValue>` to `<StringValue>`, returning `(StringValue "true")` if
   `<Value>` is `(BoolValue TRUE)` and `(StringValue "false")` otherwise.
* `<BoolValue>` to `<TextValue>`, same as above, but with text instead of
  string.
* `<FloatValue>` to `<StringValue>`.
* `<FloatValue>` to `<TextValue>`.
* `<FloatValue>` to `<IntValue>`, using a *floor* function.
* `<IntValue>` to `<StringValue>`.
* `<IntValue>` to `<TextValue>`.
* `<IntValue>` to `<FloatValue>`.
* `<IntValue>` to `<BoolValue>`, with `0` being `(BoolValue FALSE)` and
   anything else being `(BoolValue TRUE)`.
* `<StringValue>` to `<FloatValue>`.
* `<StringValue>` to `<IntValue>`.
* `<StringValue>` to `<BoolValue>`, `(BoolValue TRUE)` if the string is
   `"true"`, `(BoolValue FALSE)` if it is `"false"`. Convert to lowercase prior
   to checking.
* `<TextValue>` to `<StringValue>`, by recursively converting all content to
   `{String}`, discarding effects and newlines, and appending it all.
* `<TextValue>` to `<IntValue>`, by converting it to `<StringValue>` first.
* `<TextValue>` to `<FloatValue>`, by converting it to `<StringValue>` first.
* `<TextValue>` to `<BoolValue>`, by converting it to `<StringValue>` first.

### constant
`(constant {type: String} {value: String})`

Constant value.

**Parameters:**
* `type` is a `{String}` indicating the type the other parameter should be
   converted to.
* `value` is a `{String}` representation of the value that should be returned.

**Process:**
* Parse the value of `value` according to `type`.
* Return the corresponding `<Value>`.

**Notes:**
The `type` parameter can take the following values: `"string"`, `"float"`,
   `"int"`, and `"bool"`.

### get_allocable_address
`(get_allocable_address)`

Get an allocable address.

**Process:**
* Return an `<PointerValue>` corresponding to an unused address.

**Notes:**
Process when using the suggested `<State>` definition:
* If the `<State>`'s `freed_addresses` collection has elements, return a
`<PointerValue>` corresponding to one of its elements.
* Otherwise, create a string `addr` corresponding to `".alloc."` to which the
   `<State>`'s `allocated_data` integer has been added then return a new
   `<PointerValue>` with a singleton list containing `addr`.
As a reminder, `<State>` is not modified by the procedure.

### if_else
`(if_else <condition: Computation> <if_true: Computation> <if_false: Computation>)`

**Parameters:**
* `condition` is a `<Computation>` that will indicate which other computation to
   consider.
* `if_true` is a `<Computation>` that will be considered only if the `condition`
   is verified.
* `if_false` is a `<Computation>` that will be considered only if the `condition`
   is not verified.

**Process:**
* Compute the `<BoolValue>` resulting from `condition`.
* Interpret this `<BoolValue>` as a `{Boolean}`.
* If it yielded `TRUE`, compute and return the `<Value>` resulting from
  `if_true`, otherwise, compute and return the `<Value>` resulting from
  `if_false`.

### last_choice_index
`(last_choice_index)`

Get the index of the user's last chosen option.

**Process:**
* Return an `<IntValue>` corresponding to the `<State>`'s `last_choice_index`.

### newline
`(newline)`

Return a newline value.

**Process:**
* Return a `<TextValue>` corresponding to a newline.

### Unary operation
`(operation {operator: String} <x: Computation>)`

Interpret as `(operation operator x (BoolValue FALSE))`. It is recommended to
have the parser do that conversion automatically.

### operation
`(operation {operator: String} <x: Computation> <y: Computation>)`

Performs a basic operation.

**Parameters:**
* `operator` is the name of the operation.
* `x` is the first operand.
* `y` is the second operand.

**Process:**
* Compute `<val_x: Value>` and `<val_y: Value>`, the `<Values>` corresponding to
   `x` and `y`, respectively.
* See the *Notes* below for which operators are expected.
* Return the result of the operation.

**Notes:**
`val_x` and `val_y` always have the same type. If the returned value is a
number, it has the same type as `val_x` and `val_y`. Number types are
`<FloatValue>` and `<IntValue>`. Comparable types are `<FloatType>`,
`<IntValue>`, `<StringType>`, `<BoolType>`, and `<PointerType>`.

*Operands are numbers, returns number*:
* `divide`, returning the value corresponding to `val_x` divided by `val_y`.
   This is an integer division if and only if `val_x` is an integer.
* `minus`, returning the value corresponding to `val_x` minus `val_y`.
* `plus`, returning the value corresponding to `val_x` plus `val_y`.
* `power`, returning the value corresponding to `val_x` to the power `val_y`.
* `times`, returning the value corresponding to `val_x` times `val_y`.

*Operands are `<IntValue>`s, returns `<IntValue>`:*
* `modulo`, returning the value corresponding to `val_x` modulo `val_y`.

*Operands are `<BoolValue>`s, returns `<BoolValue>`:*
* `and`, returning `(BoolValue TRUE)` if both `val_x` and `val_y` are
  `(BoolValue TRUE)`, `(BoolValue FALSE)` otherwise. Do not evaluate `val_y` if
  `val_x` yielded `(BoolBalue FALSE)` (lazy evaluation).
* `not`, returning `(BoolValue TRUE)` if `val_x` is `(BoolValue FALSE)`.
   Otherwise, return `(BoolValue FALSE)`.

*Operands are comparable, returns `<BoolValue>`:*
* `less_than` returning `(BoolValue TRUE)` if `val_x` is less than `val_y` and
  `(BoolType FALSE)` otherwise.  `(BoolType FALSE)` is less than
  `(BoolType TRUE)`. `<PointerValue>`s can be compared by comparing the strings
  corresponding to having joined all elements in their respective string lists.

*Operands can be any type, returns `<BoolValue>`:*
* `equals` returns `(BoolValue TRUE)` if `val_x` has the same value as `val_y`,
  `(BoolType FALSE)` otherwise.  Be sure to compare values and not identity
  (value vs reference).

### relative_address
`(relative_address <target: Computation> <extra: Computation>)`

Appends to an address.

**Parameters:**
* `target` is a `<Computation>` that will yield the base address to extend.
* `extra` is a `<Computation>` corresponding to the `<StringValue>` element to
  add to the address.

**Process:**
* Compute the `<PointerValue>` corresponding to `target`.
* Compute the `<StringValue>` corresponding to `extra`.
* Return a new `<PointerValue>` corresponding to the previous `<PointerValue>`,
   but with its list of strings now having been extended by the addition of the
   string equivalent to that `<StringValue>`.

### size
`(size <target: Computation>)`

Computes the size of a list.

**Parameters:**
* `target` is a `<Computation>` that will yield a `<PointerValue>` pointing to
   a `<ListValue>`.

**Process:**
* Compute the `<PointerValue>` yielded by `target`.
* Return a new `<IntValue>` corresponding to the number of elements in the
   `<ListValue>` pointed to by that `<PointerValue>`.

### text
`(text {values: <Computation> List})`

Merges a list of text values into a single one.

**Parameters:**
* `values` is a list of `<Computation>`s that will yield `<TextValue>`s.

**Process:**
* Compute the `<Value>` corresponding ot each element of `values`.
* Return a new `<TextValue>` corresponding to these `<Values>` appended one
  after the next.

### value_of
`(value_of <target: Computation>)`

Retries the value from memory.

**Parameters:**
* `target` is a `<Computation>` that will yield the address of the memory
   element to get the value of.

**Process:**
* Compute the value of `target`.
* Return the `<Value>` pointed to by `target` in the `<State>`'s `memory`.

### extra_computation
`({extra_computation} {parameters: <Computation> List})`

Performs non-standard computation.

**Parameters:**
* `extra_computation` is the name of the extra computation.
* `parameters` is a list of parameters for this computation call.

**Process:**
* Undetermined. This is where you choose the process according to the value of
   `extra_computation` so that you can add non-standard computations.
