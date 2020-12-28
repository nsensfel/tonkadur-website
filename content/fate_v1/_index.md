---
title: "Fate (Version 1)"
menuTitle: "Fate"
weight: 3
---

When using Tonkadur, Fate is the language the author writes in. This language is
meant to provide the writer with as many tools as possible, so that they do not
feel constrained by the limitations of the language, nor find writing complex
narratives tedious.

## A few warnings first

Fate uses strong typing. This is intended to make detection of mistakes easier,
but may lead to some frustrations for authors only used to languages using
dynamic typing.

Fate does not have any special features for multi-seating/multi-player
narratives. This is by design, as adding proper support for this would make the
underlying language more complex, and thus would make it harder to create an
interpreter for it. This is however something considered for an extension
(see
[this GitHub issue about it](https://github.com/nsensfel/tonkadur/issues/5)).

You'll need to learn parentheses management, if you make anything complex. Fate
uses a LISP inspired syntax, so parentheses are everywhere. The syntax gives you
free reign over indentation, but so many parentheses does require at least some
discipline in order to be readable.

Fate is meant to be compiled. This does add an extra step to your existing
process.

Fate is very much a new language. There isn't many (any?) tools for it.

If for some reason you want to perform memory allocation, there is no automatic
garbage collection, so you will have to free whatever you allocate.

In what may seem weird for narrative scripting, Fate does not feature string
manipulation operations. Strings can be made into rich text, with complex
attributes, but you will not be able to use things like regular expressions
(or anything other than simple concatenation, really) with just the base
language. This is because of these operations would need to be implemented
directly by the interpreter anyway, and their use isn't actually common in
a narrative description, which would make requiring support for them of
any Tonkadur interpreter problematic.

## Some nice features

If you haven't closed the tab yet, here are some reasons why you *might* want
to use Fate.

It *is* a LISP inspired syntax. If that's what you like, you might even enjoy
this take on it. There's no fiddling with indentation, no wondering what symbol
does what. It's all about parentheses indicating something is performed on a
list of other things. It's not a purely functional language, though. In fact,
it's a mix of both declarative and imperative programming: sequences (or
procedures) are imperative. Computations are functional. There are lambda
functions, but they're strongly typed. Collections and structures can only be
modified through specific instructions, so it's not quite really a LISP-like
language.

There are pointers. Oh, come on, it's a plus, *right?* This makes it a lot
easier to refer to things. There's no pointer arithmetic, so you don't have to
worry about the scary stuff. Also, this lets you allocate memory, which is
useful when you want a unspecified amount of distinct instances of something.
Want to describe a story where the player can push a button as many time as
they choose, create a clone of a creature every time they do so, yet let them
fight any of these creature as their distinct instance? Well, with memory
allocation and pointers, it's easily done. Didn't you know? When writing a
narrative, the RAM's the limit. So yeah, maybe don't forget to `free` the
thousands of monster the player will no doubt create.

You can do recursion. Wait! I *am* listing the nice features! Do people really
not like recursion and pointers? Oh, well... Still, you can do recursions with
both procedures and lambda functions. Not a fan of recursion? That's alright,
you also have imperative loops: `for`, `while`, `do_while`, and even
`for_each`.

## The basics

#### Procedures (or Sequences) and Instructions
Procedures are lists of instructions and things to display. Instructions can be
applied to values, but they themselves do not return any value.  Any value not
part of an instruction found in a procedure is displayed. Any value being part
of an instruction is **not** displayed.

One way to think about it is to consider procedures as being actually two types
of things: sequences and procedures. A sequence is then a scene in the story,
and a procedure is just a construct called upon to perform instructions.

Procedures can take arguments. Values are passed by copy.

Procedures can be called in two ways: a `call` or a `jump`. A `call` will
perform the procedure before continuing with the current sequence of
instructions. A `jump` will perform the procedure **instead of** the
**current** sequence of instructions.

Procedures can be called before their definition. The compiler will simply tell
you if the definition ends up being incompatible or missing.

#### Computations
Computations are operations returning a value. Computations do not modify
anything, they simply return the result of an operation.

A special type of computation, called *lambda function*, allows the creation of
a computation that will be performed only when called upon. Those can take
parameters. What's the use of something as advanced in a narrative scripting
language? It's convenient when you want to express something like a character's
name who depends on what the player figured out. Sure, you *could* make each
instance of the name feature a series of tests to find which value to use, or
you could just use a lambda function and just put
`(eval name_of_mysterious_character)` to get the right value.

One last thing about lambda functions, which really are the only potentially
complicated thing about computations: these *are* computations, so you can use
them as such. They also cannot modify anything, as they only contain
computations and not instructions.

#### Declarations and First Level Instructions
Declarations and First Level Instructions are a special type of instruction
which can only be done from outside a procedure. This distinction means that,
for example, you cannot define a procedure from within a procedure.

#### Events
Sometimes, you might need to communicate something to the interpreter which
cannot be expressed in Fate. For example, you might want to say: "pause for 30
seconds", or "play this music". This kind of thing has been considered to not
be generic enough to mandate every interpreter supports it. Instead, events are
used.

Events are first declared, by being given a name and a list of types
corresponding to the parameters they take. Then, the `(event ...)` instruction
can be used to indicate that a certain event should occur. This will pause the
execution, and make the interpreter react to the event before continuing.

The effect of an event is purely the interpreter's responsibility. It cannot be
described in Fate. Thus, you will need to refer to the interpreter you use to
see what events are available.

#### Types
The basic `string`, `int`, `float`, and `bool` types are what one would expect.

`text` corresponds to text with decorations, see the text effect sub-section.

Two collection types are available: `(list [TYPE])` is a list of `[TYPE]`
elements, and `(set [COMPARABLE])` is a set of `[COMPARABLE]` elements.

`(ptr [TYPE])` is an address to a value of type `[TYPE]`.

Structures can be defined. They may contain other structures, but cannot be
recursive: only already defined types can be used. Pointers cannot be used to
resolve this conundrum in this version of Fate, but it may be added in the next
version (see [this GitHub
issue](https://github.com/nsensfel/tonkadur/issues/6)).

#### Player Choices
Inputs from the players are limited to the `(player_choice ...)` instruction.
It presents the player with `text` options to choose from, which execute
an associated list of instructions if chosen.

More complicated inputs, such as retrieving a `string` or an `int` from the
player require the definition and use of events.

