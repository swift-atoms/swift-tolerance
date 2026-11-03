# swift-tolerance

Use this package when you need to decide whether two floating-point values are close enough to count as equal, for example when comparing computed results against expected ones. Start from `Tolerance<Scalar>`: build one from an absolute allowance, a relative allowance or both, then ask it whether it `contains` a pair of values.

## Laws

- A pair is contained exactly when the two values are equal (`==`), or both are finite and `|lhs − rhs| ≤ absolute + relative · max(|lhs|, |rhs|)`. The two allowances add up, and the bound is inclusive.
- With both allowances zero, containment is exact floating-point equality, so `-0.0` and `0.0` match.
- Containment is symmetric and is not transitive: with `absolute: 1`, 0 matches 1 and 1 matches 2, but 0 does not match 2.
- NaN is never contained, not even with itself. An infinity matches only the same infinity, never a finite value or the opposite infinity, whatever the allowances.
- When the difference of two finite values overflows, it is compared after scaling both values by the larger magnitude. Overflow therefore never turns two distinct values into a match: `greatestFiniteMagnitude` and its negation differ by twice the larger magnitude, so they match from `relative: 2` and never through the absolute allowance alone.
- An allowance that is negative, NaN or infinite is rejected when the tolerance is built.
