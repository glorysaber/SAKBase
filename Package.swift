// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "SAKBase",
	platforms: [.macOS(.v10_14),
							.iOS(.v13),
							.tvOS(.v13),
							.watchOS(.v6)
	],
	products: [
		// Products define the executables and libraries produced by a package, and make them visible to other packages.
		.library(
			name: "SAKBase",
			targets: ["SAKBase"]),
	],
	dependencies: [
		.package(url: "git@github.com:apple/swift-numerics.git", from: "0.0.6")
		// Dependencies declare other packages that this package depends on.
		// .package(url: /* package url */, from: "1.0.0"),
	],
	targets: [
		// Targets are the basic building blocks of a package. A target can define a module or a test suite.
		// Targets can depend on other targets in this package, and on products in packages which this package depends on.
		.target(
			name: "SAKBase",
			dependencies: [.product(name: "RealModule", package: "swift-numerics")]),
		.testTarget(
			name: "SAKBaseTests",
			dependencies: ["SAKBase"]),
	]
)
