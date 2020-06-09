// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonExtensionsHelps",
    products: [
        .library(
            name: "CommonExtensionsHelps",
            targets: ["CommonExtensionsHelps"]),
    ],
    dependencies: [
        
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/jdg/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "5.14.0")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.1.1"))
    ],
    targets: [
        .target(name: "CommonExtensionsHelps",
                dependencies: [Target.Dependency.byName(name: "SwiftyJSON"),
                                                              Target.Dependency.byName(name: "MBProgressHUD"),
                                                              Target.Dependency.byName(name: "Kingfisher"),
                                                              Target.Dependency.byName(name: "RxSwift"),
                                                              Target.Dependency.byName(name: "SnapKit"),
                                                              Target.Dependency.product(name: "RxMoya", package: "Moya"),
                                                              Target.Dependency.product(name: "RxCocoa", package: "RxSwift")],
                path: "CommonExtensionsHelps/Source"),
        .testTarget(
            name: "CommonExtensionsHelpsTests",
            dependencies: ["CommonExtensionsHelps"]),
    ],
    swiftLanguageVersions: [.v5]
)
