---
menuTitle: Variables
title: "Adding Variables"
weight: 3
---
In [the previous step](/learn/start), we introduced player choices. Dynamic
content is here, but it is not going far without variables.

Fate is a strongly typed language, meaning that variables **must** be assigned
a precise type and cannot deviate from it.

Variables have to be declared before being used. Let us keep things simple for
now, and declare variables using the `local` instruction. The alternative is
`global`. The difference between the two being about access from other
contexts, something that is introduced in the next chapter.

We are trying to add a variable that corresponds to money. An `int` is thus
appropriate.

**main.fate:**

         (fate_version 1)

         (local int hero_money)
         (local int price_of_booze)

         (set hero_money 42)
         (set price_of_booze 12)

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
               Staring straight at the barman, you raise your glass and
               proclaim:
               (newline)
               "This soon-to-be world savior needs more booze!"
               (newline)
               The barman's lack of reaction is disappointing, but seeing the
               beer being poured does help improve the mood.
               (newline)
               Satisfied, you hand the barman (var price_of_booze) copper coins.
               (set hero_money
                  (- (var hero_money) (var price_of_booze))
               )
            )
            (
               ( Fall asleep )
               Deciding to break away from the expected storyline, you promptly
               fall asleep.
               (newline)
               ...
               (newline)
               Upon waking up, your hard-trained reflexes inform you that
               someone stole all your money.
               (set hero_money 0)
            )
         )

         (end)

* `(local int hero_money)` declares an `int` variable with the name
  `hero_money`.
* `(set hero_money 42)` sets the value of the `hero_money` variable to 42.
* `(var price_of_booze)` returns the current value of the `price_of_booze`
  variable.
* `(- (var hero_money) (var price_of_booze))` returns the result of subtracting
   the value of `price_of_booze` to the value of `hero_money`. All operators
   use a prefixed form.

`local`, `set`, `player_choice`, and `end`, are instructions. Instructions do
not return any value. Thus, they do not add to the printed text.

Having to continue the story from within the `player_choice` structure is going
to get tedious very fast. Let's [introduce sequences](/learn/sequences).
