---
menuTitle: "Starting"
title: "Writing a story in Fate"
weight: 1
---
* Create a folder for your story. This is not mandatory, but helps keeping
  track of the created files.
* Open up your favorite text editor, and write in `main.fate`:

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
(end)
{{< /fatecode >}}

This is a very minimal story in Fate. Let's look at what is it made of:

* The `(fate_version 1)` line must be at the top of every file. It is just
  there to inform the compiler of the used language version. It has no effect on
  the output.
* The text is mostly printed out as-is: newlines, tabs and spaces are
  considered to be a single space. No matter how many of them follow. This
  makes indentation have no effect on the output text. Furthermore such
  characters preceding text are ignored.
* `(newline)` inserts a newline in the output.
* `(end)` signals the end of the story. It needs to be there.

With this, you know how to make a static, purely textual story in Fate. Our poor
protagonist needs a refill, so we need to introduce
[Player Choices](/learn/choices) next.
