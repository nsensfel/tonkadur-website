---
title: "Main"
---
# Welcome to Tonkadur's website
Tonkadur is a tool to create interactive narratives.

### Find out all about Tonkadur
 * **Plain-text format.** Just write in your favorite editor and use your usual tools.
 * **Extensive description language (Fate).** You shouldn't feel restrained in what you can write.
 * **Strong typing.** Reduce the likeliness of errors in your descriptions.
 * **Very simple and small interpreted language (Wyrd).** Easily add support for Tonkadur to your engine.
 * **LISP inspired syntax.** No weird symbols everywhere. No annoying indentation restrictions.

Tonkadur provides a compiler from Fate to Wyrd, letting you freely describe
your stories using a feature rich language without having to worry about the
implications when it comes time to add support for it to your engine.

### Sample:
{{< fatecode >}}(define_sequence in_your_room ()
   (if_else (set:is_member visited_your_room progress)
      (text_effect narrator
         You room is still a mess. You don't have time to clean things up,
         though.
      )
      (text_effect narrator
         You room is a mess. You recall having been through every drawer while
         preparing your bag yesterday. While still unclear on how you are
         supposed to pack all the necessary things for what promises to be at
         least a year-long journey inside a small backpack, you cannot avoid
         but wasting more time contemplating the piles of items that didn't
         make the cut.
      )
   )
   (set:add! visited_your_room progress)
   (player_choice
      (option ( Look for healing items )
         (jump_to! look_for_healing_items)
      )
      (option ( No time! Let's go adventuring! )
         (jump_to! leave_your_room)
      )
   )
)
{{< /fatecode >}}

### Known alternatives
* [Inkle's Ink](https://www.inklestudios.com/ink/).
* [Yarn Spinner](https://yarnspinner.dev/).
* [Twine](https://twinery.org/).
* [Ren'Py](https://renpy.org/).
* [DLG](https://github.com/iLambda/language-dlg). Nowhere near as popular as the
other alternatives, but its approach shares more similarities with Tonkadur.
