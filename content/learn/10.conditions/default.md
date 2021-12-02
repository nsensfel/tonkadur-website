---
menuTitle: Conditionals
title: "Expressing Conditions"
weight: 10
---
In [the previous step](/learn/lambdas), we added lambda functions, which made
it possible to store computation descriptions for later use. The `smithy.fate`
is still a mess, and we couldn't handle the hero not having enough money for a
purchase. Let's add conditions to our story.

Fate has quite a few conditional constructs. `if_else`, `switch`, and `cond`
can be used both as instruction and computation. `if` is only for instructions.
* `if_else` selects between two options according to a given `bool` value.
* `switch` has a list of options, each of which is associated to a value.
   It selects the first listed option whose value is equal to the targeted
   value. When used as a computation, a default option with no associated value
   must be provided.
* `cond` has a list of options, each of which is associated to a `bool`
  computation. The first listed option for which the computation yields `(true)`
  is chosen. In the case of a computation, the last option is chosen even as a
  default value. With instructions, if no option has its condition satisfied,
  nothing happens.
* `if` is only for instructions, and applies its content only if the condition
  is verified.

All of these can be used within a `player_choice!` to control what options are
available.

Let's start our changes by checking if this is the player's first visit to the
smithy, as there is no need to give a detailed description of the place if it
is not. We can also use conditions to check if the player is able to purchase
items:

**smithy.fate:**
{{< fatecode >}}(fate_version 1)

(require smithy_inventory.fate)

;; Maybe it would be better to put this in a different file, but oh well...
(global (lambda text ((cons #weapon int))) get_weapon_offer_label)
(global (lambda text ((cons #armor int))) get_armor_offer_label)

(set! get_weapon_offer_label
   (lambda
      ( ((cons #weapon int) offer) )
      (let
         (
            (weapon (car offer))
            (price (cdr offer))
         )
         (text
            Buy "(var weapon.name)" (lp)attack: (var weapon.attack),
            precision: (var weapon.precision)(rp) for (var price) coins.
         )
      )
   )
)

(set! get_armor_offer_label
   (lambda
      ( ((cons #armor int) offer) )
      (let
         (
            (armor (car offer))
            (price (cdr offer))
         )
         (text
            Buy "(var armor.name)" (lp)defense: (var armor.defense)(rp),
            for (var price) coins.
         )
      )
   )
)

(global bool has_visited_smithy (false))

(define_sequence visit_smithy ()
   (if (not has_visited_smithy)
      As you approach the smithy, you notice that no one's there. All the wares
      are out for selling. It's almost as if this story didn't need more
      examples of lengthy dialogues.
      (newline)
      (set! has_visited_smithy (true))
   )
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
   ;; We'll improve it further once we get to loops.

   (player_choice!
      (option ( (eval get_weapon_offer_label smithy_weapons.0) )
         (visit! buy_weapon smithy_weapons.0)
         (jump_to! visit_smithy)
      )
      (option ( (eval get_weapon_offer_label smithy_weapons.1) )
         (visit! buy_weapon smithy_weapons.1)
         (jump_to! visit_smithy)
      )
      (option ( Nevermind )
         (jump_to! visit_smithy)
      )
   )
)

(define_sequence see_armors ()
   ;; We'll improve it further once we get to loops.

   (player_choice!
      (option ( (eval get_armor_offer_label smithy_armors.0) )
         (visit! buy_armor smithy_armors.0)
         (jump_to! visit_smithy)
      )
      (option ( (eval get_armor_offer_label smithy_armors.1) )
         (visit! buy_armor smithy_armors.1)
         (jump_to! visit_smithy)
      )
      (option ( Nevermind )
         (jump_to! visit_smithy)
      )
   )
)

(define_sequence buy_weapon ( ((cons #weapon int) weapon) )
   (local int money_after)

   (set! money_after (- hero.money (cdr weapon)))

   (if_else (< money_after 0)
      (
         You can't afford that.
         (newline)
         You would need (abs money_after) more coins.
      )
      (
         (set! hero.weapon (car weapon))
         (set! hero.money money_after)
         Equipped (var hero.weapon.name).
      )
   )
   (newline)
)

(define_sequence buy_armor ( ((cons #armor int) armor) )
   (local int money_after)

   (set! money_after (- hero.money (cdr armor)))

   (if_else (< money_after 0)
      (
         You can't afford that.
         (newline)
         You would need (abs money_after) more coins.
      )
      (
         (set! hero.armor (car armor))
         (set! hero.money money_after)
         Equipped (var hero.armor.name).
      )
   )
   (newline)
)
{{< /fatecode >}}

To showcase a use of `cond`, we'll add some checks that tell the player how well
they did:

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

;; Let's analyze how well the player did
(cond
   ((> hero.weapon.attack 7)
      Your feel ready to strike down any challenge.
   )
   ((>= hero.armor.defense 7)
      Your feel invincible.
   )
   ((>= hero.money 50)
      You feel good about having spent your coins sparingly.
   )
   ((true)
      You feel like you wasted your evening.
   )
)
(end!)
{{< /fatecode >}}

Lastly, we can have an example of `switch` by having the barman react to certain
hero names. Note that `The barman looks surprised` corresponds to the default
branch of that switch.

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
   "(var hero.name)?"
   (newline)
   (switch hero.name
      (Fred
         You brace for the inevitable mockery.
      )
      (Link
         You show the back of your hand to the barman.
      )
      ((string Lancelot of Camelot)
         You place halves of a coconut shell on the bar.
      )
      The barman looks surprised.
   )
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

This was a first step toward cleaning up `smithy.fate`. Next, we'll use
[loops](/learn/loops) to improve things further.

----

## Unchanged Files

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

(set! hero.money 200)

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

**smithy_inventory.fate:**
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
