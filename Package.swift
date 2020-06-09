// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonExtensionsHelps",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "CommonExtensionsHelps", targets: ["CommonExtensionsHelps"]),
    ],
    dependencies: [
        .package(url: "https://gitee.com/WWDC14/Moya.git", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://gitee.com/WWDC14/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://gitee.com/WWDC14/MBProgressHUD.git", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://gitee.com/WWDC14/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://gitee.com/WWDC14/Kingfisher.git", .upToNextMajor(from: "5.14.0")),
        .package(url: "https://gitee.com/WWDC14/SwiftyJSON.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "CommonExtensionsHelps",
                dependencies: ["Moya", "SnapKit", "MBProgressHUD", "RxSwift", "RxCocoa", "Kingfisher", "SwiftyJSON"],
                path: "CommonExtensionsHelps/Source")
    ]
)
