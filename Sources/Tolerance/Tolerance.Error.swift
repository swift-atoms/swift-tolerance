extension Tolerance {
    /// An allowance must be finite and nonnegative.
    public enum Error: Swift.Error, Sendable, Equatable {
        case invalidAllowance
    }
}
