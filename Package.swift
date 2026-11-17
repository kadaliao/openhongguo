// swift-tools-version:5.9
// openhongguo 的 Swift 包，供 App 通过 Swift Package Manager 引用：
//
//     .package(url: "https://github.com/beilunyang/openhongguo.git", from: "0.3.0")
//
// 这是 kadaliao/openhongguo 的临时发布：上游 v0.3.0 加上 V5 播放取址修复
// （beilunyang/openhongguo#13），xcframework 从这个 fork 的 Release 下载。
// 上游发布这个修复后，改回上游。
//
// 从 v0.3.1-kx.2 起 xcframework 多了 tvOS 和 tvOS 模拟器两个部分，供开心果的
// Apple TV 版用，由 bindings/mobile/add-tvos.sh 加上；其余部分和 v0.3.1-kx.1
// 逐字节相同。
//
// Go 编译出的 OpenhongguoCore.xcframework 从 GitHub Release 下载。本地开发和
// 测试用 bindings/mobile/ios/Package.swift，它引用 build.sh 生成的 xcframework。
import PackageDescription

let package = Package(
    name: "Openhongguo",
    platforms: [.iOS(.v13), .macOS(.v11), .tvOS(.v16)],
    products: [
        .library(name: "Openhongguo", targets: ["Openhongguo"]),
    ],
    targets: [
        .binaryTarget(
            name: "OpenhongguoCore",
            url: "https://github.com/kadaliao/openhongguo/releases/download/v0.3.1-kx.2/OpenhongguoCore.xcframework.zip",
            checksum: "21391e5d7f48e7fbe8d21df5a10de3ad6dbfc16ad13b3374442c4ec3acc91b69"
        ),
        .target(
            name: "Openhongguo",
            dependencies: ["OpenhongguoCore"],
            path: "bindings/mobile/ios/Sources/Openhongguo"
        ),
    ]
)
