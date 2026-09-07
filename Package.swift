// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-tolerance",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Tolerance", targets: ["Tolerance"]),
        .library(name: "Tolerance Foundation Integration", targets: ["Tolerance Foundation Integration"]),
        .library(name: "Tolerance Test Support", targets: ["Tolerance Test Support"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(name: "Tolerance", dependencies: [], path: "Sources/Tolerance"),
        .target(name: "Tolerance Foundation Integration", dependencies: ["Tolerance"], path: "Sources/Tolerance Foundation Integration"),
        .target(name: "Tolerance Test Support", dependencies: ["Tolerance"], path: "Tests/Support"),
        .testTarget(name: "Tolerance Tests", dependencies: ["Tolerance", "Tolerance Foundation Integration", "Tolerance Test Support"], path: "Tests/Tolerance Tests"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
