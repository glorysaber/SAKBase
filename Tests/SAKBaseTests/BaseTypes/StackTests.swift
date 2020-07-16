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

	func testStack() {
		var stack = Stack<Int>()

		XCTAssert(stack.count == 0)
		XCTAssert(stack.isEmpty)
		XCTAssert(stack.pop() == nil)
		XCTAssert(stack.top == nil)

		stack.push(1)
		stack.push(3)

		XCTAssert(stack.count == 2)
		XCTAssert(!stack.isEmpty)
		XCTAssert(stack.top == 3)
		XCTAssert(stack.pop() == 3)
		XCTAssert(stack.top == 1)
	}

	func test_stack_iteratesOverAll() {
		var stack = Stack<Int>()

		let values = (0...5).map { $0 }

		for index in 0...5 {
			stack.push(values[index])
		}

		var stackCount = stack.count
		for element in stack {
			XCTAssertEqual(values[stackCount - 1], element)
			stackCount -= 1
		}
	}

}
