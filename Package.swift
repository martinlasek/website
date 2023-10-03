// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "website",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.83.1"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.1.1"),
        .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "4.1.1"),
        .package(url: "https://github.com/pointfreeco/swift-html-vapor", from: "0.4.0"),
        .package(url: "https://github.com/JohnSundell/Splash.git", from: "0.16.0")
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware"),
                .product(name: "HtmlVaporSupport", package: "swift-html-vapor"),
                .product(name: "Splash", package: "Splash")
            ]
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),

            // Workaround for https://github.com/apple/swift-package-manager/issues/6940
            .product(name: "Vapor", package: "vapor"),
        ])
    ]
)
