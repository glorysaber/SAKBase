//
//  PointTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/14/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class PointTests: XCTestCase {

	func test_points_equality() {
		let point1 = PointTest(xCord: 1, yCord: 1)
		let point2 = PointTest(xCord: 1.0, yCord: 1.0)
		let point3 = PointTest(xCord: 1.1, yCord: 1.0)

		XCTAssertTrue(point1 ~= point2)
		XCTAssertFalse(point1 ~= point3)
	}

	func test_points_arithmetic() {
		let point1 = PointTest(xCord: 1, yCord: 1)

		XCTAssertTrue((point1 + point1).cordsWithin(0.00000000001,
																					 of: PointTest(xCord: 2, yCord: 2)))

		XCTAssertTrue((point1 - point1).cordsWithin(0.00000000001,
																								of: PointTest(xCord: 0.0, yCord: 0.0)))
	}
}

private extension PointTests {
	struct PointTest: Point {
		typealias PointValue = Double

		var xCord: PointValue
		var yCord: PointValue
	}
}
