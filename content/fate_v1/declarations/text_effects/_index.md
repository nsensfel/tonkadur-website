---
title: Text Effects
---
Text effects are attributes that can be given to text elements. The
effects themselves can take parameters. To avoid errors that would be difficult
to detect, Tonkadur expects text effects to be declared before being used.
Note that multiple text effects can be applied to the same text elements,
so there is no need to create text effects that combine other text effects.

Two text effects cannot have the same name, even if their parameter types
differ.

Because text effects are handled by the interpreter, it is recommended to
overlay their use by lambda functions. This way, each interpreter can simply
expose its available text effects in a file, and the definition of the lambda
functions can thus be changed according to which interpreter is used without
having to go through the whole document. Furthermore, the name of text effects
exposed by the interpreter might not match the name that would make the most
sense to use within the narrative.

### TEXT EFFECT
{{< fatecode >}}(declare_text_effect {Identifier} [T0 = TYPE] ... [TN = TYPE]){{< /fatecode >}}
Declares the text effect `{Identifier}`, with parameters of type `[T0]` ...
`[TN]`.

## Examples
* `(declare_text_effect bold)`
* `(declare_text_effect speaker string)`
* `(declare_text_effect color int int int)`
* `(declare_text_effect font string)`
* `(declare_text_effect speaker_emotion string int)`
