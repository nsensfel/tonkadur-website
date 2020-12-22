---
title: Conditionals
---
This page presents the computation operators that allow a choice depending on
some condition. All possible returned values must be of the same type.

### IF-ELSE
{{< fatecode >}}(if_else [BOOL] [C0 = COMPUTATION] [C1 = COMPUTATION]){{< /fatecode >}}

Returns `C0` is `[BOOL]` yields true, `C1` otherwise.

### COND
{{< fatecode >}}(cond ([B0 = BOOL] [C0 = COMPUTATION]) ... ([BN = BOOL] [CN = COMPUTATION])){{< /fatecode >}}

Returns `[CI]`, such that `[BI]` is the first to hold true. If there is not such
`Bi`, returns `[CN]`.

### SWITCH
{{< fatecode >}}(switch [T = COMPUTATION] ([V0 = COMPUTATION] [C0 = COMPUTATION]) ... ([VN = BOOL] [CN = COMPUTATION]) [D = COMPUTATION]){{< /fatecode >}}a

Returns the first `CI` such that `VI` is equal to `T`. If there is not such
`VI`, returns `[D]`.

## Examples
{{< fatecode >}}(cond
   ((false) (false))
   ((false) (false))
   ((true)
      (cond
         ((false) (false))
         ((true) (not (is_member 3 test_list)))
         ((true) (false))
      )
   )
)
{{< /fatecode >}}

{{< fatecode >}}(switch 3
   (0 (false))
   (1 (false))
   (3 (true))
   (2 (false))
   (false)
)
{{< /fatecode >}}

{{< fatecode >}}(if_else (true)
   (if_else (false)
      (assert (false) FAILED: instruction ifelse E)
      (set test_var (true))
   )
   (assert (false) FAILED: instruction ifelse F)
)
{{< /fatecode >}}
