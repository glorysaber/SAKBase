//
//  WeakifyTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

// swiftlint:disable discouraged_optional_boolean
class WeakifyTests: XCTestCase {

	func test_weakify_void() {

		let closure: () -> Void
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy, WeakifySpy.void)
			closure()
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
		closure()
		XCTAssertNil(spyWeak)
	}

	func test_weakify_takesNoValueReturns() {

		let closure: () -> Bool
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												default: false,
												WeakifySpy.takesNoValueReturns)

			XCTAssertNotNil(spyWeak)
			XCTAssertTrue(closure())
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		XCTAssertFalse(closure())
	}

	func test_weakify_takesNoValueReturnsOptional() {

		let closure: () -> Bool?
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												WeakifySpy.takesNoValueReturnsOptional)

			XCTAssertNotNil(spyWeak)
			XCTAssertNotNil(closure())
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		XCTAssertNil(closure())
	}

	func test_weakify_takesValue() {

		let closure: (Bool) -> Void
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												WeakifySpy.takesValue)

			XCTAssertNotNil(spyWeak)
			closure(true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		closure(true)
	}

	func test_weakify_takesOptionalValue() {

		let closure: (Bool?) -> Void
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												WeakifySpy.takesOptionalValue)

			XCTAssertNotNil(spyWeak)
			closure(nil)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		closure(nil)
	}

	func test_weakify_takesValueReturns() {

		let closure: (Bool) -> Bool
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												default: false,
												WeakifySpy.takesValueReturns)

			XCTAssertNotNil(spyWeak)
			XCTAssertEqual(closure(true), true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		XCTAssertEqual(closure(true), false)
	}

	func test_weakify_takesValueReturnsOptional() {

		let closure: (Bool) -> Bool?
		weak var spyWeak: WeakifySpy?

		do {
			let spy = WeakifySpy()
			spyWeak = spy

			closure = weakify(spy,
												WeakifySpy.takesValueReturnsOptional)

			XCTAssertNotNil(spyWeak)
			XCTAssertEqual(closure(true), true)
			XCTAssertEqual(spyWeak?.calls, 1)
		}

		XCTAssertNil(spyWeak)
		XCTAssertNil(closure(true))
	}

}

private extension WeakifyTests {
	class WeakifySpy {
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
