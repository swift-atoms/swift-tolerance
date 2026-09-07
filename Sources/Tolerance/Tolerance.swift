/// An absolute and relative allowance for numerical deviation.
/// Closeness is symmetric but need not be transitive; it is not Equatable equality.
public struct Tolerance<Scalar: FloatingPoint> {
    public let absolute: Scalar
    public let relative: Scalar

    public init(absolute: Scalar = 0, relative: Scalar = 0) throws(Error) {
        guard absolute.isFinite, relative.isFinite, absolute >= 0, relative >= 0 else {
            throw .invalidAllowance
        }
        self.absolute = absolute == 0 ? 0 : absolute
        self.relative = relative == 0 ? 0 : relative
    }

    /// Tests |lhs-rhs| <= absolute + relative * max(|lhs|, |rhs|), avoiding overflow.
    /// Equal infinities and signed zeros match. NaN and unequal infinities never match.
    public func contains(_ lhs: Scalar, _ rhs: Scalar) -> Bool {
        if lhs == rhs { return true }
        guard lhs.isFinite, rhs.isFinite else { return false }
        let difference = (lhs - rhs).magnitude
        if difference.isFinite, difference <= absolute { return true }
        let scale = max(lhs.magnitude, rhs.magnitude)
        guard scale != 0 else { return true }
        let scaledDifference = difference.isFinite
            ? difference / scale
            : (lhs / scale - rhs / scale).magnitude
        return scaledDifference <= absolute / scale + relative
    }
}

extension Tolerance: Swift.Sendable where Scalar: Swift.Sendable {}

extension Tolerance: Swift.Equatable {}
