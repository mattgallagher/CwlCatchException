// swift-tools-version:4.0
import PackageDescription

let package = Package(
	name: "CwlCatchException",
	products: [.library(name: "CwlCatchException", targets: ["CwlCatchException"])],
	targets: [
		.target(name: "CwlCatchExceptionSupport"),
		.target(name: "CwlCatchException", dependencies: ["CwlCatchExceptionSupport"]),
	]
)
