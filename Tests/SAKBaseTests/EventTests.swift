//
//  EventTests.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/14/18.
//  Copyright © 2018 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

class EventTests: XCTestCase {

	var eventHandler: Disposable? = nil

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      // TODO: Add Test expectations to test proper handler calling and disposing.
      
      
      let event = Event<Int>()
      
      let string: NSString? = NSString("Hello")
      
      eventHandler = event.addHandler(string!) {
        print($0, $1)
        return true
      }
      
      event.raise(5)
      
//      XCTAssert(event.raise(5))
      
      event.raise(3)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
