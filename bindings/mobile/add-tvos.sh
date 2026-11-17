#!/bin/sh
# add-tvos.sh 给已经编好的 OpenhongguoCore.xcframework 加上 tvOS 和 tvOS 模拟器
# 两个部分，其余部分原样保留。开心果的 Apple TV 版用。
#
#   ./add-tvos.sh IN.xcframework OUT.xcframework
#
# 官方 gomobile 没有 tvOS 目标，这里用 sagernet 的分支
# （go install github.com/sagernet/gomobile/cmd/gomobile@v0.1.13），
# 用 GOMOBILE 指定它的路径，默认是 PATH 里的 gomobile。gobind 仍用官方的。
# 它把 tvOS 的 framework 编成 macOS 那样带 Versions/ 的结构，tvOS 只认 iOS
# 那样的扁平结构，所以先展平，Info.plist 照抄 iOS 部分的。framework 的名字跟着
# 输出的文件名走，所以临时输出也叫 OpenhongguoCore.xcframework。
set -eu

in=$(cd "$(dirname "$1")" && pwd)/$(basename "$1")
out=$2
here=$(cd "$(dirname "$0")" && pwd)
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

(cd "$here/core" && "${GOMOBILE:-gomobile}" bind -target tvos,tvossimulator -iosversion 13 \
	-trimpath -ldflags="-s -w" -o "$work/tvos/OpenhongguoCore.xcframework" .)

set --
for dir in "$in"/*/; do
	set -- "$@" -framework "${dir}OpenhongguoCore.framework"
done
for slice in tvos-arm64 tvos-arm64_x86_64-simulator; do
	src="$work/tvos/OpenhongguoCore.xcframework/$slice/OpenhongguoCore.framework/Versions/A"
	dst="$work/flat/$slice/OpenhongguoCore.framework"
	mkdir -p "$dst"
	cp -R "$src/Headers" "$src/Modules" "$dst/"
	cp "$src/OpenhongguoCore" "$dst/"
	cp "$in/ios-arm64/OpenhongguoCore.framework/Info.plist" "$dst/"
	set -- "$@" -framework "$dst"
done
rm -rf "$out"
xcodebuild -create-xcframework "$@" -output "$out"
