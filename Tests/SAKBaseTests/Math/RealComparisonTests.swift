//
//  RealComparisonTests.swift
//  SAKBase
//
//  Created by Stephen Kac on 2/27/18.
//

import XCTest
import SAKBase

class RealComparisonTests: XCTestCase {

  // MARK: Comparison Tests
  func testNearEqualOperator() {
    // Can handle floats that should  be equal and epislons great than the biggest compared float
		XCTAssertTrue(1.0.within(0.00000000000001, of: 1.0))

		XCTAssertTrue(1.0.within(2.0, of: 0.1))

    // Must treat Infinity as always equal
		XCTAssertTrue(Double.greatestFiniteMagnitude.within(.infinity, of: .leastNonzeroMagnitude))

    // Must treet nan epislon as never equal
		XCTAssertFalse(1.0.within(.nan, of: 1.0))
		XCTAssertFalse(Double.zero.within(.nan, of: .zero))
		XCTAssertFalse(Double.leastNonzeroMagnitude.within(.greatestFiniteMagnitude, of: .nan))
		XCTAssertFalse(Double.greatestFiniteMagnitude.within(Double.nan, of: Double.greatestFiniteMagnitude))

    // Can handle small and big values
		XCTAssertTrue(Double.greatestFiniteMagnitude.within(1, of: Double.greatestFiniteMagnitude))
		XCTAssertTrue(Double.leastNonzeroMagnitude.within(Double.leastNonzeroMagnitude.nextUp, of: Double.zero))

		// Can handle differently signed values
		XCTAssertTrue(Double.zero.nextDown.within(0.1, of: Double.zero))
		XCTAssertTrue(Double.zero.nextDown.within(0.1, of: Double.zero.nextUp))

		XCTAssertFalse(Double.infinity.within(Double.greatestFiniteMagnitude, of: 0.0))
  }

	func testUlps() {
		XCTAssertEqual(Float32(1.0).distanceInUlps(to: Float(1.0).nextUp), 1)

		XCTAssertTrue(1.0.within(ulps: 1, of: 1.0.nextUp))
		XCTAssertEqual(1.0.distanceInUlps(to: 1.0.nextUp), 1)

		XCTAssertTrue(1.0.within(ulps: 2, of: 1.0.nextUp.nextUp))
		XCTAssertTrue(1.0.within(ulps: 2, of: 1.0.nextDown))

		XCTAssertFalse(Double.nan.within(ulps: 2, of: 1.0.nextUp.nextUp))
		XCTAssertFalse(Double.infinity.within(ulps: 2, of: 1.0.nextDown))
		XCTAssertTrue(Double.zero.within(ulps: 0, of: .zero))

		XCTAssertTrue(Double.zero.within(ulps: 1, of: -.zero))

		// Differently signed values are always false no matter what
		XCTAssertFalse((-Double.zero.nextUp).within(ulps: UInt(Int.max) - 1, of: Double.zero.nextUp))
	}
}
