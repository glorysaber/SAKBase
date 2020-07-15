//
//  MathTests.swift
//  SAKBase
//
//  Created by Stephen Kac on 2/27/18.
//

import XCTest
@testable import SAKBase

class MathTests: XCTestCase {

  
  // MARK: Comparison Tests
  func testNearEqualOperator() {
    // Can handle floats that should  be equal and epislons great than the biggest compared float
		XCTAssertTrue(1.0.within(0.00000000000001, of: 1.0))
    
		XCTAssertTrue(1.0.within(2.0, of: 0.1))

    // Must  treat Infinity as always equal
		XCTAssertTrue(Double.greatestFiniteMagnitude.within(.infinity, of: .leastNonzeroMagnitude))

    // Must treet nan epislon as never equal
		XCTAssertFalse(1.0.within(.nan, of: 1.0))
		XCTAssertFalse(Double.zero.within(.nan, of: .zero))
		XCTAssertFalse(Double.leastNonzeroMagnitude.within(.greatestFiniteMagnitude, of: .nan))
		XCTAssertFalse(Double.greatestFiniteMagnitude.within(Double.nan, of: Double.greatestFiniteMagnitude))

    // Can handle small and big values
		XCTAssertTrue(Double.greatestFiniteMagnitude.within(1, of: Double.greatestFiniteMagnitude))
		XCTAssertTrue(Double.leastNonzeroMagnitude.within(Double.leastNonzeroMagnitude.nextUp, of: Double.zero))
  }

	func testUlps() {
		XCTAssertEqual(Float32(1.0).distanceInUlps(to: Float(1.0).nextUp), 1)

		XCTAssertTrue(1.0.within(ulps: 1, of: 1.0.nextUp))
		XCTAssertEqual(1.0.distanceInUlps(to: 1.0.nextUp), 1)

		XCTAssertTrue(1.0.within(ulps: 2, of: 1.0.nextUp.nextUp))
		XCTAssertTrue(1.0.within(ulps: 2, of: 1.0.nextDown))
	}
}
