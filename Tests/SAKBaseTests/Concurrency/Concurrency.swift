//
//  Concurrency.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 1/20/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
@testable import SAKBase

class Concurrency: XCTestCase {

  func testParrallelWrite() {

    let firstAccess = XCTestExpectation(description: "Dual Access 1")
    let secondAccess = XCTestExpectation(description: "Dual Access 1")
    let rangeToLoop = 0...100000

    let lockedValue = Lock(value: [Int]())

    DispatchQueue.main.async(group: nil, qos: .userInteractive, flags: []) { [lockedValue] in
      for num in rangeToLoop.reversed() {
        lockedValue.edit {
          $0.append(num)
        }
      }
      firstAccess.fulfill()
    }

    DispatchQueue.main.async(group: nil, qos: .userInteractive, flags: []) { [lockedValue] in
      for num in rangeToLoop {
        lockedValue.edit {
          $0.append(num)
        }
      }
      secondAccess.fulfill()
    }

    wait(for: [firstAccess, secondAccess], timeout: 10.0)

    let newMap = lockedValue.value.reduce(into: [:]) { frequency, value in
      frequency[value, default: 0] += 1
    }

    XCTAssert(newMap.count == rangeToLoop.count)

    // All values must appear exactly twice
    XCTAssert(newMap.contains {
      $1 != 2
    } ==  false)

  }

  func testParrallelRead() {
    let rangeToLoop = 0...1000
    let lockedValue = Lock(value: Array(rangeToLoop))

    self.measure {
      let firstAccess = XCTestExpectation(description: "Dual Access 1")
      let secondAccess = XCTestExpectation(description: "Dual Access 1")

      // Operation

			DispatchQueue(label: "1").async(qos: .userInteractive) { [lockedValue] in
        for num in rangeToLoop {
          XCTAssert(num == lockedValue.value[num])
        }
        firstAccess.fulfill()
      }

			DispatchQueue(label: "2").async(qos: .userInteractive) {[lockedValue] in
        for num in (rangeToLoop).reversed() {
          XCTAssert(num == lockedValue.value[num])
        }
        secondAccess.fulfill()
      }

      for num in (rangeToLoop).reversed() {
        XCTAssert(num == lockedValue.value[num])
      }

      wait(for: [firstAccess, secondAccess], timeout: 5.0)

    }
  }
}
