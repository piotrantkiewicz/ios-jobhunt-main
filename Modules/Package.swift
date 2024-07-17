// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "DesignKit",
            targets: ["DesignKit"]
        ),
        .library(
            name: "JHLogin",
            targets: ["JHLogin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.7.0"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
    ],
    targets: [
        .target(
            name: "DesignKit",
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "JHLogin",
            dependencies: [
                "DesignKit",
                "PhoneNumberKit",
                "SnapKit"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
