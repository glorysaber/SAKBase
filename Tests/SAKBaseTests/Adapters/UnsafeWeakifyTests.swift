//
//  UnsafeWeakifyTests.swift
//  SAKBaseTests
//
//  Created by Stephen Kac on 7/16/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import XCTest
import SAKBase

// swiftlint:disable discouraged_optional_boolean
class UnsafeWeakifyTests: XCTestCase {

	func test_unsafeWeakify_void() {

		let closure: () -> Void
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy, UnsafeWeakifySpy.void)
			closure()
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesNoValueReturns() {

		let closure: () -> Bool
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesNoValueReturns)

			XCTAssertEqual(closure(), true)
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesNoValueReturnsOptional() {

		let closure: () -> Bool?
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesNoValueReturnsOptional)

			XCTAssertEqual(closure(), true)
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesValue() {

		let closure: (Bool) -> Void
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesValue)

			closure(true)
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesOptionalValue() {

		let closure: (Bool?) -> Void
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesOptionalValue)

			closure(nil)
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesValueReturns() {

		let closure: (Bool) -> Bool
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesValueReturns)

			XCTAssertEqual(closure(true), true)
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

	func test_unsafeWeakify_takesValueReturnsOptional() {

		let closure: (Bool) -> Bool?
		weak var spyWeak: UnsafeWeakifySpy?

		do {
			let spy = UnsafeWeakifySpy()
			spyWeak = spy

			closure = unsafeWeakify(spy,
															UnsafeWeakifySpy.takesValueReturnsOptional)

			XCTAssertNotNil(closure(true))
			XCTAssertEqual(spy.calls, 1)
		}

		XCTAssertNil(spyWeak)
	}

}

private extension UnsafeWeakifyTests {
	class UnsafeWeakifySpy {
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
