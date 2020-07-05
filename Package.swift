// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "website",
    dependencies: [
      .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
      .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
      .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "1.0.0"),
      .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),
      .package(url: "https://github.com/vapor/crypto.git", from: "3.3.3"),
    ],
    targets: [
      .target(
        name: "App",
        dependencies: [
          "Vapor",
          "Leaf",
          "FluentPostgreSQL",
          "Authentication",
          "Crypto"
        ]
      ),
      .target(name: "Run", dependencies: ["App"]),
      .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

