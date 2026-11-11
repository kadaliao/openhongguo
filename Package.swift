// swift-tools-version:5.9
// openhongguo 的 Swift 包，供 App 通过 Swift Package Manager 引用：
//
//     .package(url: "https://github.com/beilunyang/openhongguo.git", from: "0.2.0")
//
// 这是 kadaliao/openhongguo 的临时发布：v0.2.0 加上播放签名修复
// （beilunyang/openhongguo#7），xcframework 从这个 fork 的 Release 下载。
// 上游合并并发布新版本后，改回上游。
//
// Go 编译出的 OpenhongguoCore.xcframework 从 GitHub Release 下载。本地开发和
// 测试用 bindings/mobile/ios/Package.swift，它引用 build.sh 生成的 xcframework。
import PackageDescription

let package = Package(
    name: "Openhongguo",
    platforms: [.iOS(.v13), .macOS(.v11)],
    products: [
        .library(name: "Openhongguo", targets: ["Openhongguo"]),
    ],
    targets: [
        .binaryTarget(
            name: "OpenhongguoCore",
            url: "https://github.com/kadaliao/openhongguo/releases/download/v0.2.1-kx.1/OpenhongguoCore.xcframework.zip",
            checksum: "1f2d82a837b97539a9f4904d6ab0049d320ba99db0c4f783b039d9f489c55cbc"
        ),
        .target(
            name: "Openhongguo",
            dependencies: ["OpenhongguoCore"],
            path: "bindings/mobile/ios/Sources/Openhongguo"
        ),
    ]
)
