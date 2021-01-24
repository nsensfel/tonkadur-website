---
title: Sequences and Procedures
menuTitle: Sequences
weight: 6
---
Sequences and procedures are the same thing. These are named lists of
instructions and values, which can be called upon at any point where
instructions can be used. They can take parameters.

Procedures do not return values. It is however possible to emulate something
similar, by passing a pointer as a parameter and storing a "return" value into
it.

These are also intended to be used to describe scenes.

The execution of a sequence can be terminated by using the `(done)`
instruction.  The execution of the narrative can be terminated by using the
`(end)` instruction.

Any value not part of an instruction will simply be displayed when it is
reached during the procedure's execution.

Sequences can be used before their definition, the compiler will raise an error
if the use ends up being incorrect.

Execution of a sequence can be started in two ways: `(call sequence_name)` will
execute the sequence then continue with the execution of the current
instruction list; `(jump_to sequence_name)` will replace the current
instruction list by the execution of the sequence. If one were to ignore
variables, the `(jump_to sequence_name)` instruction is similar to performing
`(call sequence_name) (done)`.

{{< fatecode >}}(define_sequence {String} (([C0 = TYPE] {V0 = String}) ... ([CN = TYPE] {VN = String})) [I0 = INSTRUCTIONS|VALUE] ... [IM = INSTRUCTIONS|VALUE]){{< /fatecode >}}
**Effect:** Defines the sequence `{String}`, with variables `V0` ... `VN` of types `C0` ...`CN` as parameters, and instructions `I0` ... `IM` as content.

**Acceptable Aliases:** `declare_sequence`, `def_seq`, `define_procedure`, `declare_procedure`, `def_proc`.

#### Examples
{{< fatecode >}}(define_sequence in_your_room ()
   (ifelse
      (is_member visited_your_room progress)
      (text_effect narrator
         You room is still a mess. You don't have time to clean things up,
         though.
      )
      (text_effect narrator
         You room is a mess. You recall having been through every drawer while
         preparing your bag yesterday. While still unclear on how you are
         supposed to pack all the necessary things for what promises to be at
         least a year-long journey inside a small backpack, you cannot avoid
         but wasting more time contemplating the piles of items that didn't
         make the cut.
      )
   )
   (add visited_your_room progress)
   (player_choice
      (
         ( Look for healing items )
         (jump_to look_for_healing_items)
      )
      (
         ( No time! Let's go adventuring! )
         (jump_to leave_your_room)
      )
   )
)
{{< /fatecode >}}

{{< fatecode >}}(define_sequence index_of_loop
   (
      ((ptr int) result_holder)
      ((list int) collection)
      (int target)
   )
   (local int collection_size)
   (local int i)

   (set collection_size (size collection))

   (for (set i 0) (< (var i) (var collection_size)) (set i (+ (var i) 1))
      (if (= (access collection (var i)) (var target))
         (
            (set (at result_holder) (var i))
            (done)
         )
      )
   )
   (set (at result_holder) -1)
)
{{< /fatecode >}}


{{< fatecode >}}(define_sequence index_of_jump
   (
      ((ptr int) result_holder)
      ((list int) collection)
      (int target)
      (int i)
      (int collection_size)
   )
   (ifelse (= (var i) (var collection_size))
      (set (at result_holder) -1)
      (ifelse (= (access collection (var i)) (var target))
         (set (at result_holder) (var i))
         (jump index_of_jump
            (var result_holder)
            (var collection)
            (var target)
            (+ (var i) 1)
            (var collection_size)
         )
      )
   )
)
{{< /fatecode >}}
