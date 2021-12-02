---
title: Text
---
### TEXT
{{< fatecode >}}(text [TEXT]){{< /fatecode >}}

### ADD TEXT EFFECT
{{< fatecode >}}(add_text_effect ({String} [P0 = COMPUTATION] ... [PN = COMPUTATION]) [TEXT]){{< /fatecode >}}

### NEW LINE
{{< fatecode >}}(newline){{< /fatecode >}}

### JOIN
{{< fatecode >}}(join_text [TEXT LIST|TEXT SET] [TEXT]){{< /fatecode >}}
Returns a text value corresponding to all elements of the text collection being
appended, with `[TEXT]` having been put in between each pair.
