---
menuTitle: Sequences
title: "Introducing Sequences"
weight: 4
---
In [the previous step](/learn/variables), we introduced variables. The story is
starting to have branches, but writing them from within a `player_choice`
construct is awkward. To resolve this, *sequences* are introduced.

Sequences are named lists of instructions. They do *not* have to be defined
before being used, but the definition must be found at some point. Since
instructions do not return any value, neither do sequences.

Sequences define their own context, meaning that `local` variables from outside
the sequence cannot be accessed and, conversely, `local` variables from the
sequence cannot be accessed outside of it.

Entering a sequence can be done in two ways:
* By visiting, in which case the sequence is executed and the story continues.
* By jumping, in which case the sequence replaces the current story execution.

When in doubt, prefer visiting to jumping, as the latter is mainly intended for
optimization purposes.

Sequences can be entered again from themselves, making recursion possible.

Sequences can take parameters.


**main.fate:**

{{< fatecode >}}(fate_version 1)

(global int hero_money)

(set hero_money 42)

Once upon a time, starting a story with these words wasn't considered
a cliche. Starting in a tavern might also not be seen as very
original.  Having the main character be an street orphan, raised by
some mysterious sage all to end up as a mercenary with an uncommonly
strong sense of honor probably isn't going to lead to any praises for
novelty either. Maybe you should drink to that.
(newline)
Or maybe you shouldn't. This isn't your first mug. Not your second
either.  Drinking to forget that you are a stereotypical hero isn't
going to solve anything. Worse, the alcoholic trait is part of the
image.
(newline)
As you contemplate your own pointless description, your gaze leaves
what turns out to be an already empty glass in your hand and finds the
barman.

(player_choice
   (
      ( Ask the barman for a refill )
      (visit get_a_refill)
   )
   (
      ( Fall asleep )
      (jump_to fall_asleep)
   )
)

(define_sequence pay ( (int cost) )
   (set hero_money
      (- (var hero_money) (var cost))
   )
)

(define_sequence get_a_refill ()
   (local int price_of_booze)

   (set price_of_booze 12)

   Staring straight at the barman, you raise your glass and proclaim:
   (newline)
   "This soon-to-be world savior needs more booze!"
   (newline)
   The barman's lack of reaction is disappointing, but seeing the beer
   being poured does help improve the mood.
   (newline)
   Satisfied, you hand the barman (var price_of_booze) copper coins.
   (visit pay (var price_of_booze))
)

(define_sequence fall_asleep ()
   Deciding to break away from the expected storyline, you promptly
   fall asleep.
   (newline)
   ...
   (newline)
   Upon waking up, your hard-trained reflexes inform you that someone
   stole all your money.
   (set hero_money 0)
   (newline)
   This set-back was more than you could take. You give up on this
   barely coherent story.
   (end)
)

(end)
{{< /fatecode >}}

* `(visit get_a_refill)` makes a visit to the sequence `get_a_refill`. Since
   that sequence does not take parameters, none need to be provided.
* `(jump_to fall_asleep)` stops the execution of the main instruction list and
  proceeds to using the sequence `fall_asleep` instead. Here again, no
  arguments are expected by `fall_asleep`. Notice how the `fall_asleep` sequence
  ends with `(end)`: since there is no return from it, the original `(end)`
  would not be reached and thus a new one is required to end the story.
* `(visit pay (var price_of_booze))` makes a visit to the `pay` sequence, which
  does require a parameter.
* `(global int hero_money)` has replaced `(local int hero_money)`, because that
  variable needs to be accessible from within the sequences.
* `(local int price_of_booze)` has been moved to the `get_a_refill` sequence,
  as there is no reason to have it be defined across the whole story.
* The `pay` sequence cannot directly access the `price_of_booze` variable, as
  it is `local` and from another sequence, hence the use of a parameter to
  communicate the correct amount.

With this, the `player_choice` have become much more readable. However, the file
itself is starting to become hard to read. The solution is then to [split the
content into multiple files](/learn/files).
