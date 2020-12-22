---
title: File Management
---
Fate narratives have one main file, but this file can use the contents of other
files, and these files in turn can also use the contents of other files. Three
issues arise then: some things must be declared before they are used, nothing
should be declared multiple times, and where are the files?

The absolute path to each file is computed in order to detect whether it has
already been loaded. The given paths are expected to be relative. They are then
resolved by attempting access from the following, in order: the current file's
directory; the include directories passed as parameter to the executable; the
calling executable's directory.

Dependency cycles will raise compiling errors.

The first "instruction" on each file must be `(fate_version 1)`. Values cannot
be placed before either, obviously.

{{< fatecode >}}(require {string}){{< /fatecode >}}

**Effect:** If the file at `{string}` has not yet been loaded, load it.

{{< fatecode >}}(include {string}){{< /fatecode >}}

**Effect:** Load the `{string}`, even if it has already been loaded.

#### Examples
* `(require bonus_sequence.fate)`
* `(include types/plant.fate)`
* `(require ../guild/merchants.fate)`
* `(include ../what/../are/../you/../doing/../there.fate)`
* `(require oh/../oh/../oh/../this_is_fine.fate)`

Example of Fate file:
{{< fatecode >}};;; A story of great importance
(fate_version 1)

(require include/events.fate)
(require include/text_effects.fate)

(require scenes/the_holiday_forest.fate)

`Twas a long time ago... Longer now that it seems... In a place that can't be
referenced here because I'm pretty sure the transcript is copyrighted.

(jump_to not_the_tree_door_i_would_have_chosen)
{{< /fatecode >}}
