// swift-tools-version:5.9
// openhongguo 的 Swift 包，供 App 通过 Swift Package Manager 引用：
//
//     .package(url: "https://github.com/beilunyang/openhongguo.git", from: "0.4.1")
//
// 这是 kadaliao/openhongguo 的临时发布 v0.4.1-kx.1：Go 代码和上游 v0.4.1 相同，
// xcframework 多了 tvOS 和 tvOS 模拟器两个部分，供开心果的 Apple TV 版用，由
// bindings/mobile/add-tvos.sh 加上；iOS、iOS 模拟器和 macOS 三个部分和上游
// v0.4.1 的逐字节相同。上游的 xcframework 带上 tvOS 后，改回上游。
//
// v0.4.1-kx.3 在 kx.1 上加了 beilunyang/openhongguo#16（播放接口返回空时改走
// video_tab），xcframework 由这个 fork 自己编译（iOS、macOS 用官方 gomobile，
// tvOS 用 add-tvos.sh）。同一个 Release 里还有开心果 Android 用的 aar。
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
            url: "https://github.com/kadaliao/openhongguo/releases/download/v0.4.1-kx.3/OpenhongguoCore.xcframework.zip",
            checksum: "0449c9be17c7605efcc8334eb7428b171eece7d84947b97c3bfb1648c976c83b"
        ),
        .target(
            name: "Openhongguo",
            dependencies: ["OpenhongguoCore"],
            path: "bindings/mobile/ios/Sources/Openhongguo"
        ),
    ]
)
