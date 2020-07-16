//
//  Point3Tests.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class Point3Tests: XCTestCase {

	func test_pointsDouble_equality() {
		let point1 = Point3DoubleTest(xCord: 1, yCord: 1, zCord: 1)
		let point2 = Point3DoubleTest(xCord: 1.0, yCord: 1.0, zCord: 1)
		let point3 = Point3DoubleTest(xCord: 3.9, yCord: 1.0, zCord: 1)

		XCTAssertTrue(point1.cordsWithin(2.0, of: point2))
		XCTAssertFalse(point1.cordsWithin(2.0, of: point3))
		XCTAssertTrue(point1.within(ulps: Point3IntTest(xCord: 0, yCord: 1, zCord: 1), of: point1))
	}

	func test_pointsDouble_arithmetic() {
		let point1 = Point3DoubleTest(xCord: 1, yCord: 1, zCord: 1)

		XCTAssertTrue(
			(point1 + point1)
				.cordsWithin(0.00000000001,
										 of: Point3DoubleTest(xCord: 2, yCord: 2, zCord: 2)))

		XCTAssertTrue(
			(point1 - point1)
				.cordsWithin(0.00000000001,
										 of: Point3DoubleTest(xCord: 0.0, yCord: 0.0, zCord: 0.0)))

		var pointVar = point1

		pointVar += point1
		XCTAssertTrue(pointVar.cordsWithin(0.000000001, of: point1 + point1))

		let pointX = pointVar * Point3DoubleTest(xCord: 0, yCord: 1, zCord: 2)
		XCTAssertTrue(pointX.cordsWithin(0.000000001, of: Point3DoubleTest(xCord: 0, yCord: pointVar.yCord, zCord: 2)))

		let pointDiv = pointVar / Point3DoubleTest(xCord: 2, yCord: 2, zCord: 2)
		XCTAssertTrue(pointDiv.cordsWithin(0.0000001, of: point1))

		XCTAssertEqual(Point3DoubleTest(xCord: 3.0, yCord: 4.0, zCord: 3.0), Point3DoubleTest(xCord: 3.2, yCord: 4.3, zCord: 3.4).floored())
	}

	func test_pointsInt_equality() {
		let point1 = Point3IntTest(xCord: 1, yCord: 1, zCord: 1)
		let point2 = Point3IntTest(xCord: 1, yCord: 1, zCord: 1)
		let point3 = Point3IntTest(xCord: 2, yCord: 2, zCord: 3)

		XCTAssertTrue(point1 == point2)
		XCTAssertFalse(point1 == point3)
	}

	func test_pointsInt_arithmetic() {
		let point1 = Point3IntTest(xCord: 1, yCord: 1, zCord: 1)

		XCTAssertTrue(
			(point1 + point1)
				== Point3IntTest(xCord: 2, yCord: 2, zCord: 2))

		XCTAssertTrue(
			(point1 - point1)
				==  Point3IntTest(xCord: 0, yCord: 0, zCord: 0))

		var pointVar = point1

		pointVar += point1
		XCTAssertTrue(pointVar == (point1 + point1))

		let pointX = pointVar * Point3IntTest(xCord: 0, yCord: 1, zCord: 0)
		XCTAssertTrue(pointX == Point3IntTest(xCord: 0, yCord: pointVar.yCord, zCord: 0))

		let pointDiv = pointVar / Point3IntTest(xCord: 2, yCord: 2, zCord: 2)
		XCTAssertTrue(pointDiv == point1)
	}
}

private extension Point3Tests {
	struct Point3DoubleTest: Point3 {
		var xCord: Double
		var yCord: Double
		var zCord: Double
	}

	struct Point3IntTest: Point3 {
		var xCord: Int
		var yCord: Int
		var zCord: Int
	}
}
