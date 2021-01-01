//
//  DisposableTests.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/15/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

import Foundation

import XCTest
import SAKBase

class DisposableTests: XCTestCase {

	func test_disposableContainer_doesDispose_whenDestroyed() {
		weak var spy: DisposableSpy?

		do {
			let spyStrong = DisposableSpy()
			spy = spyStrong

			_ = DisposeContainer(toBeDisposed: spyStrong)

		XCTAssertEqual(spy?.disposeCalls, 1)
		}

		XCTAssertNil(spy)
	}

	func test_disposableContainer_doesNotDispose_whenDestroyed() {
		var spy: DisposableSpy?
		let disposable: Disposable?

		do {
			let spyStrong = DisposableSpy()
			spy = spyStrong

			disposable = DisposeContainer(toBeDisposed: spyStrong)
				.removeDisposableFromContainer()

			XCTAssertEqual(spy?.disposeCalls, 0)
		}

		disposable?.dispose()
		XCTAssertEqual(spy?.disposeCalls, 1)
	}
}

// MARK: - Helpers
private extension DisposableTests {
	class DisposableSpy: Disposable {

		var disposeCalls = 0

		func dispose() {
			disposeCalls += 1
		}
	}
}
