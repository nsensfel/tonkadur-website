---
menuTitle: Pointers
title: "Addressing Pointers"
weight: 6
---
In [the previous step](/learn/files), we split the story into multiple files
to make it more readable. Now, we'll see pointers, because they were needed for
two features that were glossed over in what was presented before:
* Using sequences as imperative procedures.
* Prompting the user for content.

A pointer is a value that indicates a location in memory where some
data is stored. This can be used as a value that will tell some instruction
where to put data.

Pointers have types. For example, `(ptr int)` is the type corresponding to
pointers to `int` data.

To compute a pointer to a variable `v`, simply write `(ptr v)`.

Given a pointer `p`, the variable being pointed to can be referred to using
`(at p)`.

**data.fate:**
{{< fatecode >}}(fate_version 1)

(global int hero_money)
(global string hero_name)

(set hero_money 42)
{{< /fatecode >}}
**get_a_refill.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)
(require actions.fate)

(define_sequence lower_price_of_booze
   (
      ((ptr int) price_pointer)
      (int decrease)
   )
   Great! The price of booze just lowered from (at price_pointer)
   (set (at price_pointer)
      (-
         (at price_pointer)
         (var decrease)
      )
   )
   to (at price_pointer)!
)

(define_sequence get_a_refill ()
   (local int price_of_booze)

   (set price_of_booze 12)

   Staring straight at the barman, you raise your glass and proclaim:
   (newline)
   "This soon-to-be world savior needs more booze!"
   (newline)
   The barman's lack of reaction is disappointing, but seeing the beer being
   poured does help improve the mood.
   (newline)
   Satisfied, you hand the barman (var price_of_booze) copper coins.
   (visit pay (var price_of_booze))
   (newline)
   The barman sighs, then asks:
   (prompt_string (ptr hero_name) 2 64 What is your name, then, hero?)
   (var hero_name)?
   (newline)
   The barman looks surprised.
   (newline)
   (visit lower_price_of_booze (ptr price_of_booze) 4)
   (newline)
   "I have heard of you, (var hero_name)," the barman exclaims, "I have a quest
   for you!"
   (newline)
   It's your turn to sigh.
   (newline)
   The barman hands you a bag, and says:
   (newline)
   "Take this pre-payment and head to the smithy."
   (newline)
)
{{< /fatecode >}}

* `(prompt_string (ptr hero_name) 2 64 What is your name, then, hero?)` prompts
  the player with `What is your name, then, hero?` and expects a string input
  with a size between `2` and `64` characters. This input is stored at `(ptr
  hero_name)`, which means that `hero_name` takes that value.
* The `lower_price_of_booze` sequence shows how pointers can be used to modify
  variables outside of a sequence's range.
* `(var price_of_booze)` is equivalent to `(at (ptr price_of_booze))`.

Our hero, who'll obviously end up being the lost heir of some royal family,
should already have good equipment. It would be useful to have a character
sheet, so [let's create one](/learn/structures).

----

## Unchanged Files
**actions.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)

(define_sequence pay ( (int cost) )
   (set hero_money
      (- (var hero_money) (var cost))
   )
)
{{< /fatecode >}}

**falling_asleep.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)

(define_sequence fall_asleep ()
   Deciding to break away from the expected storyline, you promptly fall
   asleep.
   (newline)
   ...
   (newline)
   Upon waking up, your hard-trained reflexes inform you that someone stole all
   your money.
   (set hero_money 0)
   (newline)
   This set-back was more than you could take. You give up on this barely
   coherent story.
   (end)
)
{{< /fatecode >}}

**main.fate:**
{{< fatecode >}}(fate_version 1)

Once upon a time, starting a story with these words wasn't considered a cliche.
Starting in a tavern might also not be seen as very original.  Having the main
character be an street orphan, raised by some mysterious sage all to end up as
a mercenary with an uncommonly strong sense of honor probably isn't going to
lead to any praises for novelty either. Maybe you should drink to that.
(newline)
Or maybe you shouldn't. This isn't your first mug. Not your second either.
Drinking to forget that you are a stereotypical hero isn't going to solve
anything. Worse, the alcoholic trait is part of the image.
(newline)
As you contemplate your own pointless description, your gaze leaves what turns
out to be an already empty glass in your hand and finds the barman.

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

(require get_a_refill.fate)
(require falling_asleep.fate)

(end)
{{< /fatecode >}}
