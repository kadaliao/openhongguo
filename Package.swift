// swift-tools-version:5.9
// openhongguo 的 Swift 包，供 App 通过 Swift Package Manager 引用：
//
//     .package(url: "https://github.com/beilunyang/openhongguo.git", from: "0.3.0")
//
// 这是 kadaliao/openhongguo 的临时发布：上游 v0.3.0 加上 V5 播放取址修复
// （beilunyang/openhongguo#13），xcframework 从这个 fork 的 Release 下载。
// 上游发布这个修复后，改回上游。
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
            url: "https://github.com/kadaliao/openhongguo/releases/download/v0.3.1-kx.1/OpenhongguoCore.xcframework.zip",
            checksum: "297eec4ff3b6121886a1f3909b97be17d6e84e2fd9a75d76c6dfc92c29ef40d8"
        ),
        .target(
            name: "Openhongguo",
            dependencies: ["OpenhongguoCore"],
            path: "bindings/mobile/ios/Sources/Openhongguo"
        ),
    ]
)
