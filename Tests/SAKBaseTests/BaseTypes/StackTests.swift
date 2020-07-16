//
//  StackTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/14/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class StackTests: XCTestCase {

	func test_stack() {
		var stack = Stack<Int>()

		XCTAssertTrue(stack.isEmpty)
		XCTAssertNil(stack.pop())
		XCTAssertNil(stack.top)

		stack.push(1)
		stack.push(3)

		XCTAssertEqual(stack.count, 2)
		XCTAssertFalse(stack.isEmpty)
		XCTAssertEqual(stack.top, 3)
		XCTAssertEqual(stack.pop(), 3)
		XCTAssertEqual(stack.top, 1)

		XCTAssertTrue(stack.isEmpty)
		XCTAssertNil(stack.pop())
		XCTAssertNil(stack.top)
	}

	func test_stack_iteratesOverAll() {
		var stack = Stack<Int>()

		let values = Array(0...5)

		for index in 0...5 {
			stack.push(values[index])
		}

		var stackCount = stack.count
		stack.forEachPop { element in
			XCTAssertEqual(values[stackCount - 1], element)
			stackCount -= 1
		}

		XCTAssertEqual(stack.count, 0)
	}

}
