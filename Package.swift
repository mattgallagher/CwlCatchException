// swift-tools-version:4.2
import PackageDescription

let package = Package(
	name: "CwlCatchException",
	targets: [
		.target(name: "CwlCatchException", dependencies: ["CwlCatchExceptionSupport"]),
		.target(name: "CwlCatchExceptionSupport"),
		.testTarget(name: "CwlCatchExceptionTests", dependencies: ["CwlCatchException"])
	]
)
