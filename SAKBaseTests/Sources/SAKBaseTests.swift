//
//  SAKBase_macOSTests.swift
//  SAKBase-macOSTests
//
//  Created by Stephen Kac on 2/25/18.
//

import XCTest
@testable import SAKBase

class SAKBaseTests: XCTestCase {
  
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  

  
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
  
  func testCommand() {
    
    class TestClass {
      var bool = false
    }
    
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
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
    
  }
}
