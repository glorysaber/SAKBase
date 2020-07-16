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

	weak var eventHandler: Disposable? = nil

	func test_event_doesGetDisposed() {

		let event = Event<Int>()

		do {
			let eventHandler = event.addHandler() { _ in }
			XCTAssertEqual(event.handlerCount, 1)
			self.eventHandler = eventHandler
		}

		XCTAssertNil(eventHandler)
		XCTAssertEqual(event.handlerCount, 0)
	}

	func test_event_doesRaiseAllHandlers() {

		let event = Event<Int>()

		var disposables = Array<Disposable>()

		var calls = 0

		for _ in 0..<3 {
			disposables.append(event.addHandler { _ in
				calls += 1
			})
		}

		event.raise(1)

		XCTAssertEqual(calls, 3)
	}

	func test_event_sendsRaisedValue() {
		let event = Event<Int>()

		var givenValue: Int?

		let disposable = event.addHandler {
			givenValue = $0
		}

		event.raise(13)

		XCTAssertEqual(givenValue, 13)

		disposable.dispose()
	}

}
