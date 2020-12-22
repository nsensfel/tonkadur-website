---
title: Events
---
Events are how a Fate narrative can communicate to the interpreter that
something which cannot be expressed in Fate needs to be performed. The execution
is paused until the event is resolved by the interpreter. To avoid mistakes, any
event type must be declared before use.

#### EVENT
{{< fatecode >}}(declare_event_type {string} [C0 = TYPE] ... [CN = TYPE]){{< /fatecode >}}
**Effect:** An event with the name `{string}` and taking parameters of types
`[C0]`, ..., `[CN]` can be used.

## Examples
* `(declare_event_type user_string_input rich_text (ptr string))`
* `(declare_event_type wait int)`
* `(declare_event_type set_background_to string)`
* `(declare_event_type rumble)`
