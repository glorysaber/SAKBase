//
//  UniversalIDTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/14/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class UniversalIDTests: XCTestCase {

	func testUniversalID() {
		let uniqueIDs = UniversalID()
		var uniqueSet = Set<Identifier>()

		// Generate 100000 ids
		for _ in 0..<100000 {
			uniqueSet.insert(uniqueIDs.nextID())
		}

		// If the count is 10000 and both sets are equal than 10000 unique ids were created
		XCTAssert(uniqueIDs.ids == uniqueSet)
		XCTAssert(uniqueIDs.ids.count == 100000)

		// Make sure id is removed properly
		let id = uniqueSet.popFirst()!
		uniqueIDs.remove(id: id)
		XCTAssert(!uniqueIDs.ids.contains(id))
	}

}
