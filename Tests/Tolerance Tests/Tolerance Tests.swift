import Tolerance
import Testing

@Suite struct ToleranceTests {
    @Test func allowanceIsValidated() {
        for value in [-1.0, .infinity, .nan] {
            #expect(throws: Tolerance::Failure.invalidAllowance) { try Tolerance(absolute: value) }
            #expect(throws: Tolerance::Failure.invalidAllowance) { try Tolerance(relative: value) }
        }
    }

    @Test func exceptionalValuesAndNontransitivity() throws {
        let exact = try Tolerance<Double>()
        #expect(exact.contains(.infinity, .infinity))
        #expect(exact.contains(-0.0, 0.0))
        #expect(!exact.contains(.nan, .nan))
        #expect(!exact.contains(.infinity, -.infinity))
        let allowance = try Tolerance<Double>(absolute: 1)
        #expect(allowance.contains(0, 1))
        #expect(allowance.contains(1, 2))
        #expect(!allowance.contains(0, 2))
    }

    @Test func overflowDoesNotTurnDistinctValuesIntoMatches() throws {
        let huge = Double.greatestFiniteMagnitude
        let allowance = try Tolerance<Double>(absolute: huge, relative: 0.5)
        #expect(!allowance.contains(huge, -huge))
        #expect(!allowance.contains(-huge, huge))
        #expect(try Tolerance<Double>(relative: 2).contains(huge, -huge))
        #expect(try Tolerance<Double>(absolute: .leastNonzeroMagnitude).contains(0, .leastNonzeroMagnitude))
    }
}
