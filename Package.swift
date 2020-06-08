// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonExtensionsHelps",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CommonExtensionsHelps",
            targets: ["CommonExtensionsHelps"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/jdg/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.14.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "CommonExtensionsHelps",
                path: "CommonExtensionsHelps/Source")
    ]
)
