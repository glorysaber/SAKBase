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

    func test() {

      let event = Event<Int>()
      
      let string: NSString? = NSString("Hello")
      
      eventHandler = event.addHandler(string!) {
        print($0, $1)
        return true
      }
      
      event.raise(5)
      
      event.raise(3)
    }

}
