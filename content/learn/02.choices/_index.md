---
menuTitle: "Player Choices"
title: "Asking the Player"
weight: 2
---
In [the previous step](/learn/start), we saw a minimal text story written in Fate.
Now, we need to interact with the player.

There are three ways to interact with the player:
* Asking them to choose between options.
* Prompting them for an integer.
* Prompting them for a string.

The last two require notions that haven't been introduced yet, so let's give
the player a simple choice instead:

**main.fate:**
{{< fatecode >}}(fate_version 1)
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

(player_choice!
   (option ( Ask the barman for a refill )
      Staring straight at the barman, you raise your glass and proclaim:
      (newline)
      "This soon-to-be world savior needs more booze!"
   )
   (option ( Fall asleep )
      Deciding to break away from the expected storyline, you promptly fall
      asleep.
   )
   (option ( Resolve whether P=NP )
      Sadly, the output for this choice would require some concepts that
      haven't been introduced yet, so let's never mention it again.
   )
)

(end!)
{{< /fatecode >}}

In this version, the player is able to interact with the story: once
`player_choice!` is reached, the output stops and the player is presented with
options. Here, three choices are available. A choice is made of a label and a
list of instructions. The label is the text which is displayed to player (for
example `Fall asleep`). The list of instructions is what will be performed if
that choice is selected. Putting text where instructions are expected simply
outputs the text. In fact, all the content of the previous step was
instructions. Once a choice has been made and the instructions have been
performed, the story continues past the `player_choice!` construct.

But something critical is missing. Indeed, how can you get a refill without
money? Just how much money does our hero have? Will it be enough to quench that
terrible thirst? Let's [introduce variables](/learn/variables).
