---
menuTitle: <Computation>
title: Computation
weight: 3
---
This page presents all the `<Computation>`s that can be performed in Wyrd.
`<Computation>`s do not modify the memory, but they always return a `<Value>`.

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

**Parameters:**

**Process:**

### get_allocable_address
`(get_allocable_address)`

**Process:**

### if_else
`(if_else <condition: Computation> <if_true: Computation> <if_false: Computation>)`

**Parameters:**

**Process:**

### last_choice_index
`(last_choice_index)`

**Process:**

### newline
`(newline)`

**Process:**

### Unary operation
`(operation {operator: String} <x: Computation>)`

**Parameters:**

**Process:**

### operation
`(operation {operator: String} <x: Computation> <y: Computation>)`

**Parameters:**

**Process:**

### relative_address
`(relative_address <target: Computation> <extra: Computation>)`

**Parameters:**

**Process:**

### size
`(size <target: Computation>)`

**Parameters:**

**Process:**

### text
`(text {values: <Computation> List})`

**Parameters:**

**Process:**

### value_of
`(value_of <target: Computation>)`

**Parameters:**

**Process:**

### extra_computation
`({extra_computation} {parameters: <Computation> List})`

**Parameters:**

**Process:**
