// swift-tools-version:5.9
// openhongguo 的 Swift 包，供 App 通过 Swift Package Manager 引用：
//
//     .package(url: "https://github.com/beilunyang/openhongguo.git", from: "0.2.0")
//
// 这是 kadaliao/openhongguo 的临时发布：上游 main（2769fb6，准备中的 0.3.0，
// 含播放签名修复和弹幕），xcframework 从这个 fork 的 Release 下载。
// 上游发布 0.3.0 后，改回上游。
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
            url: "https://github.com/kadaliao/openhongguo/releases/download/v0.3.0-kx.1/OpenhongguoCore.xcframework.zip",
            checksum: "b15787e324c875543deae925b1c0c6d77226edde35effe96413cd18eb5af4b8d"
        ),
        .target(
            name: "Openhongguo",
            dependencies: ["OpenhongguoCore"],
            path: "bindings/mobile/ios/Sources/Openhongguo"
        ),
    ]
)
