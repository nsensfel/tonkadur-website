---
menuTitle: Files
title: "Splitting into Multiple Files"
weight: 5
---
In [the previous step](/learn/sequences), we introduced sequences. This made
branching the story easier, but having many sequences in a file made the flow
difficult to read. To resolve this, the content is going to be split into
multiple files.

By using `(require path_to_file)`, the content of `path_to_file` is explored,
but only if that file has not already been explored.

* Create a new file, `data.fate`, with the following content:

         (fate_version 1)

         (global int hero_money)

         (set hero_money 42)

* Create a new file, `actions.fate`, with the following content:

         (fate_version 1)

         (require data.fate)

         (define_sequence pay ( (int cost) )
            (set hero_money
               (- (var hero_money) (var cost))
            )
         )

* Create a new file, `get_a_refill.fate`, with the following content:

         (fate_version 1)

         (require actions.fate)

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

* Create a new file, `falling_asleep.fate`, with the following content:
         (fate_version 1)

         (require data.fate)

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

**main.fate:**

         (fate_version 1)

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

         (require get_a_refill.fate)
         (require falling_asleep.fate)

         (end)

With this, the story is much more easy to follow. Let's continue by looking
at [the actually-not-scary-at-all pointers](/learn/pointers).
