//
//  Disposable.swift
//  SAKBase
//
//  Created by Stephen Kac on 7/15/20.
//  Copyright © 2020 Stephen Kac. All rights reserved.
//

/// Automatically disposes of a event upon deinit
public class DisposeContainer: Disposable {
	private weak var toBeDisposed: Disposable?

	public init(toBeDisposed: Disposable) {
		self.toBeDisposed = toBeDisposed
	}

	/// Removes the responsibility of disposing the related class from the container
	public func removeDisposableFromContainer() -> Disposable? {
		defer {
			toBeDisposed = nil
		}
		return toBeDisposed
	}

	/// Manually disposes of the contained disposable
	public func dispose() {
		toBeDisposed?.dispose()
	}

	deinit {
		dispose()
	}
}

/// Lets you dispose of a connected type.
public protocol Disposable: AnyObject {
	func dispose()
}
