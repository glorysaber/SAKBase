//
//  BindingCommandTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/14/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class BindingCommandTests: XCTestCase {

	func testBindingCommand() {
		/*
		Tests the BindingCommands ability to undo and execute a closure.
		*/
		command: do {
			let bindingCommand = BindingCommand(exec: {
				return true
			})
			XCTAssert(bindingCommand.execute()) // Should return true
		}

		undoCommand: do {
			let bindingCommand = BindingCommand(exec: {
				return true
			}, undo: {
				return true
			})

			bindingCommand.execute()
			XCTAssert(bindingCommand.undo()) // Should return true
		}

	}

}
