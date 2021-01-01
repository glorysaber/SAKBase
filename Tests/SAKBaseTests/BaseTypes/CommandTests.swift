//
//  CommandTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/14/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class CommandTests: XCTestCase {

	func testCommand() {

		let testClass = TestClass()

		// TEST: Testing basic operation of command to execute

		let executeExclusiveCommand = Command(actor: testClass, value: true) {
			guard let value = $1 else { return false }
			$0.bool = value
			return true
		}

		XCTAssert(executeExclusiveCommand.execute())
		XCTAssert(testClass.bool)
		testClass.bool = false
		XCTAssert(executeExclusiveCommand.getUndo() == nil)

		// TEST: Testing exec operation and then undoing of that operation

		let executeUndoCommand = Command(actor: testClass, value: true, exec: {
			guard let value = $1 else { return false }
			$0.bool = value
			return true
		}, undo: {
			guard let value = $1 else { return false }
			$0.bool = !value
			return true
		})

		XCTAssert(executeUndoCommand.execute()) // Should successdully execute
		XCTAssert(testClass.bool) // The Boolean should have changed to true
		XCTAssert(executeUndoCommand.getUndo() != nil) // Should be able to get the undo command
		XCTAssert(executeUndoCommand.undo()) // Should be able to successfully execute the Undo command
		XCTAssert(!testClass.bool) // The boolean should be back to false

		// TEST: Testing the undo functionality after the command has already been uninitialized
		var uninitialized: Command? = Command(actor: testClass, value: true, exec: {
			guard let value = $1 else { return false }
			$0.bool = value
			return true
		}, undo: {
			guard let value = $1 else { return false }
			$0.bool = !value
			return true
		})

		XCTAssert(uninitialized?.execute() ?? false)
		XCTAssert(testClass.bool == true)
		let undoCommand = uninitialized?.getUndo()
		uninitialized = nil
		XCTAssert(undoCommand?() ?? false)
		XCTAssert(!(testClass.bool))

	}

}

// MARK: - Helpers
extension CommandTests {
	class TestClass {
		var bool = false
	}
}
