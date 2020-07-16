//
//  StongifyTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

// swiftlint:disable discouraged_optional_boolean
class StongifyTests: XCTestCase {

	func test_strongify_void() {

		let closure: () -> Void
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy, StongifySpy.void)
			closure()
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		closure()
		XCTAssertNotNil(spyWeak)
	}

	func test_strongify_takesNoValueReturns() {

		let closure: () -> Bool
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesNoValueReturns)

			XCTAssertNotNil(spyWeak)
			XCTAssertTrue(closure())
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		XCTAssertTrue(closure())
	}

	func test_strongify_takesNoValueReturnsOptional() {

		let closure: () -> Bool?
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesNoValueReturns)

			XCTAssertNotNil(spyWeak)
			XCTAssertNotNil(closure())
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		XCTAssertNotNil(closure())
	}

	func test_strongify_takesValue() {

		let closure: (Bool) -> Void
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesValue)

			XCTAssertNotNil(spyWeak)
			closure(true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		closure(true)
	}

	func test_strongify_takesOptionalValue() {

		let closure: (Bool?) -> Void
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesOptionalValue)

			XCTAssertNotNil(spyWeak)
			closure(nil)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		closure(nil)
	}

	func test_strongify_takesValueReturns() {

		let closure: (Bool) -> Bool
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesValueReturns)

			XCTAssertNotNil(spyWeak)
			XCTAssertEqual(closure(true), true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		XCTAssertEqual(closure(false), true)
	}

	func test_strongify_takesValueReturnsOptional() {

		let closure: (Bool) -> Bool?
		weak var spyWeak: StongifySpy?

		do {
			let spy = StongifySpy()
			spyWeak = spy

			closure = strongify(spy,
													StongifySpy.takesValueReturnsOptional)

			XCTAssertNotNil(spyWeak)
			XCTAssertEqual(closure(true), true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNotNil(spyWeak)
		XCTAssertNotNil(closure(true))
	}

}

private extension StongifyTests {
	class StongifySpy {
		var calls = 0

		func void() {
			calls += 1
		}

		func takesNoValueReturns() -> Bool {
			calls += 1
			return true
		}

		func takesNoValueReturnsOptional() -> Bool? {
			calls += 1
			return true
		}

		func takesValue(_: Bool) {
			calls += 1
		}

		func takesOptionalValue(_: Bool?) {
			calls += 1
		}

		func takesValueReturns(_: Bool) -> Bool {
			calls += 1
			return true
		}

		func takesValueReturnsOptional(_: Bool) -> Bool? {
			calls += 1
			return true
		}
	}
}
