---
menuTitle: Structures
title: "Structuring the Data"
weight: 7
---
In [the previous step](/learn/pointers), we added pointers, which made it
possible to change data from other contexts/sequences. As we add more and more
data, it becomes clear that some structuring is needed.

Structures are types. Types must be declared before being used. This also
prevents recursive types.

The fields of a structure are initialized at the same time as the structure.

Fields of a structure can be accessed in two ways: using the
`struct_var.field_name` notation, or the `(field struct_var field_name)` one.
If `struct_ptr` is a pointer to a structure, `struct_ptr.field_name` will also
work.

To set the value of a structure's fields, one can use the `set!` instruction or,
to set multiple fields at once, the `set_fields!` one. Note that omitting the
`!` at the end of `set_fields` is also valid Fate, but performs a computation
instead of a instruction: the structure is not modified, but a copy with the
modifications performed is returned.

The name of user-defined types are expected to start with `#`. This ensures
backward compatibility if a type with a similar name is introduced in a future
(non-major) version of Fate. A warning will be raised during compilation if this
convention is not upheld.

**data.fate:**
{{< fatecode >}}(fate_version 1)

(declare_structure #weapon
   (text name)
   (int attack)
   (int precision)
)

(declare_structure #armor
   (text name)
   (int defense)
)

(declare_structure #character
   (string name)
   (int money)
   (#weapon weapon)
   (#armor armor)
)

(global #character hero)

(struct:set_fields! hero.weapon
   (name (text "Legendary" sword))
   (attack 3)
   (precision 50)
)

(struct:set_fields! hero.armor
   (name (text "Refined" attire))
   (defense 1)
)

(set! hero.money 42)
{{< /fatecode >}}

* `(text "Refined" attire)` generates a `text` value containing a textual
  representation of the values passed as parameter. `"Refined" attire` is, by
  itself, a `string`, and thus incompatible with the `text` field without a
  conversion taking place.
* Because `hero_money` and `hero_name` have been removed in favor of a
  structure, they should be replaced in the other files by `hero.money` and
  `hero.name`.

With this, it is time for our hero to get some proper gear, [let's see what
collection is available at the smithy](/learn/collections).

----

## (Mostly) Unchanged Files

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
   (set! (at price_pointer)
      (- (at price_pointer) decrease)
   )
   to (at price_pointer)!
)

(define_sequence get_a_refill ()
   (local int price_of_booze)

   (set! price_of_booze 12)

   Staring straight at the barman, you raise your glass and proclaim:
   (newline)
   "This soon-to-be world savior needs more booze!"
   (newline)
   The barman's lack of reaction is disappointing, but seeing the beer being
   poured does improve your mood.
   (newline)
   Satisfied, you hand the barman (var price_of_booze) copper coins.
   (visit! pay price_of_booze)
   The barman sighs, then asks:
   (prompt_string! (ptr hero.name) 2 64 What is your name, then, hero?)
   (var hero.name)?
   (newline)
   The barman looks surprised.
   (newline)
   (visit! lower_price_of_booze (ptr price_of_booze) 4)
   (newline)
   "I have heard of you, (var hero.name)," the barman exclaims, "I have a quest
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

**actions.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)

(define_sequence pay ( (int cost) )
   (set! hero.money (- hero.money cost))
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
   (set! hero.money 0)
   (newline)
   This set-back was more than you could handle. You give up on this barely
   coherent story.
   (end!)
)
{{< /fatecode >}}

**main.fate:**
{{< fatecode >}}(fate_version 1)

(require get_a_refill.fate)
(require falling_asleep.fate)


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

(player_choice!
   (option ( Ask the barman for a refill )
      (visit! get_a_refill)
   )
   (option ( Fall asleep )
      (jump_to! fall_asleep)
   )
)

k(end!)
{{< /fatecode >}}
