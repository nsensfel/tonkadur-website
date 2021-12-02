---
menuTitle: Collections
title: "Collections"
weight: 8
---
In [the previous step](/learn/structures), we added structures, which made
having some amounts of data more manageable. Still, what about when we need to
have hundreds of elements? Collections are here to manage that.

Fate has three types of collections:
* Sets, which only contain a single instance of each element, can only be used
  to store elements of one of the comparable types (`string`, `text`, `int`,
  `float`, `bool`) and pointers. The elements are automatically sorted in
  ascending order.
* Lists, which can be made for one of any type.
* Cons, which are pairs of two elements of any types.

There are [quite a few computations](/fate_v1/computations/collections) and
[instructions](/fate_v1/instructions/collections) available to handle
collections.

Let's add a new file, `smithy_inventory.fate`:
{{< fatecode >}}(fate_version 1)

(require data.fate)

(global (list (cons #weapon int)) smithy_weapons)
(global (list (cons #armor int)) smithy_armors)

(list:add!
   (cons
      (struct:set_fields (default #weapon)
         (name (text An Iron Rod))
         (attack 10)
         (precision 70)
      )
      176
   )
   smithy_weapons
)
(list:add!
   (cons
      (struct:set_fields (default #weapon)
         (name (text A Magnificient Brick))
         (attack 6)
         (precision 90)
      )
      110
   )
   smithy_weapons
)

(list:add!
   (cons
      (struct:set_fields (default #armor)
         (name (text A raincoat?!))
         (defense 7)
      )
      160
   )
   (cons
      (struct:set_fields (default #armor)
         (name (text A nice cape))
         (defense 3)
      )
      50
   )
   smithy_armors
)
{{< /fatecode >}}

We'll also need the actual smithy scene, so let's put in another file,
`smithy.fate`.

**IMPORTANT NOTE:** Don't worry if it looks awful at the moment, the next
chapters are going to introduce a lot of things to make it *much*, *much*
easier to write.

**smithy.fate:**
{{< fatecode >}}(fate_version 1)

(require smithy_inventory.fate)

(define_sequence visit_smithy ()
   ;; This thing is going to show up every time, which isn't great.
   As you approach the smithy, you notice that no one's there. All the wares
   are out for selling. It's almost as if this story didn't need more examples
   of lengthy dialogues.
   (newline)
   ;; We'll want to start here the next time we enter this sequence.
   You have (var hero.money) coins.
   (newline)
   What will you look at?
   (player_choice!
      (option ( Let's see the weapons )
         (jump_to! see_weapons)
      )
      (option ( Let's see the armors )
         (jump_to! see_armors)
      )
      (option ( Nothing, let's go back to the bar )
      )
   )
)

(define_sequence see_weapons ()
   ;; We'll soon replace this mess with something way better.

   (local text weapon_a_label)
   (local text weapon_b_label)

   (visit! get_weapon_label
      (list:access 0 smithy_weapons)
      (ptr weapon_a_label)
   )
   (visit! get_weapon_label
      smithy_weapons.1
      (ptr weapon_b_label)
   )

   (player_choice!
      (option ( (var weapon_a_label) )
         (visit! buy_weapon smithy_weapons.0)
         (jump_to! visit_smithy)
      )
      (option ( (var weapon_b_label) )
         (visit! buy_weapon (list:access 1 smithy_weapons))
         (jump_to! visit_smithy)
      )
      (option ( Nevermind )
         (jump_to! visit_smithy)
      )
   )
)

(define_sequence see_armors ()
   ;; We'll soon replace this mess with something way better.

   (local text armor_a_label)
   (local text armor_b_label)

   (visit! get_armor_label
      smithy_armors.0
      (ptr armor_a_label)
   )
   (visit! get_armor_label
      smithy_armors.1
      (ptr armor_b_label)
   )

   (player_choice!
      (option ( (var armor_a_label) )
         (visit! buy_armor smithy_armors.0)
         (jump_to! visit_smithy)
      )
      (option ( (var armor_b_label) )
         (visit! buy_armor smithy_armors.1)
         (jump_to! visit_smithy)
      )
      (option ( Nevermind )
         (jump_to! visit_smithy)
      )
   )
)

;; A terrible way to get labels
(define_sequence get_weapon_label
   (
      ((cons #weapon int) weapon_offer)
      ((ptr text) label)
   )
   (local #weapon weapon)
   (local int price)

   (set! weapon (car weapon_offer))
   (set! price (cdr weapon_offer))

   (set! (at label)
      (text
          Buy "(var weapon.name)" (lp)attack: (var weapon.attack),
          precision: (var weapon.precision)(rp) for (var price) coins.
      )
   )
)

;; A terrible way to get labels
(define_sequence get_armor_label
   (
      ((cons #armor int) armor_offer)
      ((ptr text) label)
   )
   (local #armor armor)
   (local int price)

   (set! armor (car armor_offer))
   (set! price (cdr armor_offer))

   (set! (at label)
      (text
          Buy "(var armor.name)" (lp)defense: (var armor.defense)(rp),
          for (var price) coins.
      )
   )
)

(define_sequence buy_weapon ( ((cons #weapon int) weapon) )
   ;; We can't even deny a sell yet...
   (set! hero.weapon (car weapon))
   Equipped (var hero.weapon.name).
   (newline)
)

(define_sequence buy_armor ( ((cons #armor int) armor) )
   ;; We can't even deny a sell yet...
   (set! hero.armor (car armor))
   Equipped (var hero.armor.name).
   (newline)
)
{{< /fatecode >}}

Now, add `(require smithy.fate)` at the start of the **get_a_refill.fate**
file, then add `(visit! visit_smithy)` at the end of the `get_a_refill`
sequence, so that our hero indeed goes to visit this great shop.

* `(list (cons weapon int))` indicates a list of `weapon` and `int` pairs.
* `(list:add! something smithy_weapons)` adds `something` to the
  `smithy_weapons` collection. Without the `!`, this would be a computation
  returning a copy of `smithy_weapons` with the added weapon, but no
  modification of the `smithy_weapons` collection itself would occur. You can
  have multiple `something` to add to the same list in the same `list:add` call.
* `(list:access 0 my_list)` gets you the first element of `my_list`. If the
   index is a constant, it is preferable to write `my_list.0` instead.
* `(cons something something_else)` creates a pair with these two elements.
* `(car weapon_offer)` returns the first element of the `weapon_offer` pair.
* `(cdr weapon_offer)` returns the second element of the `weapon_offer` pair.


Overall, the `smithy.fate` file is a mess. Let's start cleaning it up. We'll
use loops, conditionals, and lambda functions to make it much cleaner. Let's
start with the least expected one: [lambda functions](/learn/lambdas).

----

## (Mostly) Unchanged Files

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

**get_a_refill.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)
(require actions.fate)
(require smithy.fate)

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
   (visit! visit_smithy)
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

(end!)
{{< /fatecode >}}
