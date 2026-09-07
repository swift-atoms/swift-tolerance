# Tolerance

`Tolerance<Scalar>` specifies nonnegative, finite absolute and relative allowances. `contains(a, b)` tests `|a-b| <= absolute + relative * max(|a|, |b|)` using scaled arithmetic to avoid overflow. Boundary comparisons still have the rounding behavior of Scalar. Negative or nonfinite allowances throw `Tolerance<Scalar>.Error.invalidAllowance`.

Closeness is symmetric but not transitive: it does not define Equation, Equatable, ordering, or hash identity. Equal infinities and positive/negative zero match; NaN and unequal infinities do not. Equality of the tolerance values themselves compares their coefficients.

The operation is restricted to floating-point values. General SignedNumeric subtraction can overflow even when a closeness test could be decided. The core uses only Swift; Foundation integration is separate.
