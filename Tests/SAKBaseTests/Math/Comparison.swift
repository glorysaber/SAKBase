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
    // Canhandle floats that should  be equal and epislons great than the biggest compared float
    XCTAssert(areFloats(1.0, 1.0, equalWithin: 1.0))
    
    XCTAssert(areFloats(1.0, 1.0, equalWithin: 2.0))
    
    // Must  treat Infinity as always equal
    XCTAssert(areFloats(Double.greatestFiniteMagnitude, Double.leastNonzeroMagnitude, equalWithin: Double.infinity))
    
    // Must traet nan epislon as never equal
    XCTAssert(!areFloats(1.0, 1.0, equalWithin: Double.nan))
    XCTAssert(!areFloats(Double.zero, Double.zero, equalWithin: Double.nan))
    XCTAssert(!areFloats(Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude, equalWithin: Double.nan))
    XCTAssert(!areFloats(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude, equalWithin: Double.nan))
    
    // Can handle small and big values
    XCTAssert(areFloats(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude, equalWithin: 1))
    XCTAssert(areFloats(Double.leastNonzeroMagnitude, Double.zero, equalWithin: Double.leastNonzeroMagnitude.nextUp))
  }
  
}
