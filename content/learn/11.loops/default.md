---
menuTitle: Loops
title: "Doing Things Over and Over"
weight: 11
---
[The previous step](/learn/conditions) introduced conditions, making it
possible to change the flow of execution according to the value of variables.
In this step, we look at loops, which will make instructions be executed a
certain number time depending on a condition, or just for each element of a
collection.

Fate offers the following loop constructs:
* `while`, to execute instructions if and as many time as a condition is
   verified.
* `do_while`, to execute instructions at least once, then as many time as a
   condition is verified.
* `for`, a loop that has pre-instructions, a condition to verify before each
   execution of the main body, the main body of instructions itself, then
   post-instructions, which are executed before checking the condition.
* `for_each`, a loop that executes for each member of a collection.

The `for_each` loops can also be used within a `player_choice!` to control what
options are available.

Let's change how armors and weapons are displayed to the player:

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
   (player_choice!
      (foreach smithy_weapons weapon
         (option ( (eval get_weapon_offer_label weapon) )
            (visit! buy_weapon weapon)
         )
      )
      (option ( Nevermind ) )
   )
   (jump_to! visit_smithy)
)

(define_sequence see_armors ()
   ;; Not as good as a for_each in this case, but let's use a for to show how
   ;; it can be done.

   (player_choice!
      (for
         ( (i 0) )
         (< i (list:size smithy_armors))
         ( (i (+ i 1)) )

         (option ( (eval get_armor_offer_label (list:access i smithy_armors)) )
            (visit! buy_armor (list:access i smithy_armors))
         )
      )
      (option ( Nevermind ) )
   )
   (jump_to! visit_smithy)
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

Let's also look at a loop not within a `player_choice!` construct. We'll have
the player try to count sheeps:

**falling_asleep.fate:**
{{< fatecode >}}(fate_version 1)
(require data.fate)

(global (list string) affirmative_messages)

(list:add!
   Indeed.
   (string Sounds about right.)
   Yes.
   Agreed.
   (string That's correct.)
   True.
   Undoubtedly.
   Certainly.
   (string Without a doubt.)
   Correct.
   Affirmative.
   affirmative_messages
)

(global (lambda string ()) get_affirmative_message
   (lambda ()
      (list:access
         (rand 0 (- (list:size affirmative_messages) 1))
         affirmative_messages
      )
   )
)

(define_sequence count_sheeps ()
   (local int sheeps 0)

   You start imagining some pasture with no sheeps.

   (while (< sheeps 100)
      (local int player_guess)
      (local int new_sheeps (rand 1 20))

      (if_else (= new_sheeps 1)
         ( A single sheep appears. )
         ( (var new_sheeps) sheeps appear. )
      )

      (set! sheeps (+ sheeps new_sheeps))

      (prompt_integer! (ptr player_guess) 0 120 How many sheeps are there now?)

      (if_else (= sheeps player_guess)
         (eval get_affirmative_message)
         (
            No. It was (var sheeps), you're pretty sure. The doubt wakes you up.
            (newline)
            (break!)
         )
      )
      (newline)
   )
)

(define_sequence fall_asleep ()
   Deciding to break away from the expected storyline, you attempt to fall
   asleep. It's not easy, though. Maybe counting sheeps would help?

   (visit! count_sheeps)
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

[The next step of this tutorial](/learn/going_deeper) goes deeper into all the
concepts that were already explored.

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

**actions.fate:**
{{< fatecode >}}(fate_version 1)

(require data.fate)

(define_sequence pay ( (int cost) )
   (set! hero.money (- hero.money cost))
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
