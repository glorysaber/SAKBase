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

	func test_pointsDouble_equality() {
		let point1 = PointDoubleTest(xCord: 1, yCord: 1)
		let point2 = PointDoubleTest(xCord: 1.0, yCord: 1.0)
		let point3 = PointDoubleTest(xCord: 3.9, yCord: 1.0)

		XCTAssertTrue(point1.cordsWithin(2.0, of: point2))
		XCTAssertFalse(point1.cordsWithin(2.0, of: point3))
		XCTAssertTrue(point1.within(ulps: PointIntTest(xCord: 0, yCord: 1), of: point1))

		XCTAssertTrue(point1 == point2)
	}

	func test_pointsDouble_arithmetic() {
		let point1 = PointDoubleTest(xCord: 1, yCord: 1)

		XCTAssertTrue(
			(point1 + point1)
				.cordsWithin(0.00000000001,
										 of: PointDoubleTest(xCord: 2, yCord: 2)))

		XCTAssertTrue(
			(point1 - point1)
				.cordsWithin(0.00000000001,
										 of: PointDoubleTest(xCord: 0.0, yCord: 0.0)))

		var pointVar = point1

		pointVar += point1
		XCTAssertTrue(pointVar.cordsWithin(0.000000001, of: point1 + point1))

		let pointX = pointVar * PointDoubleTest(xCord: 0, yCord: 1)
		XCTAssertTrue(pointX.cordsWithin(0.000000001, of: PointDoubleTest(xCord: 0, yCord: pointVar.yCord)))

		let pointDiv = pointVar / PointDoubleTest(xCord: 2, yCord: 2)
		XCTAssertTrue(pointDiv.cordsWithin(0.0000001, of: point1))

		XCTAssertEqual(PointDoubleTest(xCord: 3.0, yCord: 4.0), PointDoubleTest(xCord: 3.2, yCord: 4.3).floored())
	}

	func test_pointsInt_equality() {
		let point1 = PointIntTest(xCord: 1, yCord: 1)
		let point2 = PointIntTest(xCord: 1, yCord: 1)
		let point3 = PointIntTest(xCord: 2, yCord: 2)

		XCTAssertTrue(point1 == point2)
		XCTAssertFalse(point1 == point3)
	}

	func test_pointsInt_arithmetic() {
		let point1 = PointIntTest(xCord: 1, yCord: 1)

		XCTAssertTrue(
			(point1 + point1)
				== PointIntTest(xCord: 2, yCord: 2))

		XCTAssertTrue(
			(point1 - point1)
				==  PointIntTest(xCord: 0, yCord: 0))

		var pointVar = point1

		pointVar += point1
		XCTAssertTrue(pointVar == (point1 + point1))

		let pointX = pointVar * PointIntTest(xCord: 0, yCord: 1)
		XCTAssertTrue(pointX == PointIntTest(xCord: 0, yCord: pointVar.yCord))

		let pointDiv = pointVar / PointIntTest(xCord: 2, yCord: 2)
		XCTAssertTrue(pointDiv == point1)
	}
}

private extension PointTests {
	struct PointDoubleTest: Point {
		var xCord: Double
		var yCord: Double
	}

	struct PointIntTest: Point {
		var xCord: Int
		var yCord: Int
	}
}
