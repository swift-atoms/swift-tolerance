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
        .target(name: "Tolerance Foundation Integration", dependencies: [.target(name: "Tolerance")], path: "Sources/Tolerance Foundation Integration"),
        .target(name: "Tolerance Test Support", dependencies: [.target(name: "Tolerance")], path: "Tests/Support"),
        .testTarget(name: "Tolerance Tests", dependencies: [.target(name: "Tolerance"), .target(name: "Tolerance Test Support")], path: "Tests/Tolerance Tests"),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
