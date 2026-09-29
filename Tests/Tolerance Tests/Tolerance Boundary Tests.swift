import Tolerance
import Testing

@Suite
struct `Tolerance boundaries` {
    @Test
    func `invalid allowances are rejected`() {
        for (absolute, relative) in [(-1.0, 0.0), (0.0, -1.0), (.nan, 0.0), (0.0, .infinity)] {
            #expect(throws: Tolerance<Double>.Error.invalidAllowance) {
                try Tolerance(absolute: absolute, relative: relative)
            }
        }
    }

    @Test
    func `zero tolerance contains only equal values`() throws {
        let exact = try Tolerance<Double>()
        #expect(exact.contains(1, 1))
        #expect(exact.contains(0, -0.0))
        #expect(!exact.contains(1, 1.0.nextUp))
    }

    @Test
    func `the absolute allowance is inclusive`() throws {
        let tolerance = try Tolerance<Double>(absolute: 0.5)
        #expect(tolerance.contains(1, 1.5))
        #expect(!tolerance.contains(1, 1.5.nextUp))
    }

    @Test
    func `the relative allowance scales with the larger magnitude`() throws {
        let tolerance = try Tolerance<Double>(relative: 0.01)
        #expect(tolerance.contains(100, 101))
        #expect(!tolerance.contains(100, 102))
    }

    @Test
    func `containment is symmetric`() throws {
        let tolerance = try Tolerance<Double>(absolute: 0.1, relative: 0.01)
        for (a, b) in [(1.0, 1.05), (100.0, 101.5), (-3.0, 3.0), (0.0, 1e-300)] {
            #expect(tolerance.contains(a, b) == tolerance.contains(b, a))
        }
    }

    @Test
    func `NaN is never contained and equal infinities are`() throws {
        let loose = try Tolerance<Double>(absolute: 1_000, relative: 1)
        #expect(!loose.contains(.nan, .nan))
        #expect(!loose.contains(1, .nan))
        #expect(loose.contains(.infinity, .infinity))
        #expect(!loose.contains(.infinity, .greatestFiniteMagnitude))
    }

    @Test
    func `a difference that overflows still compares relatively`() throws {
        let max = Double.greatestFiniteMagnitude
        #expect(try Tolerance<Double>(relative: 3).contains(max, -max))
        #expect(!(try Tolerance<Double>(relative: 1).contains(max, -max)))
    }
}
