//
//  asyncOperation.swift
//  SAKBase_MacOS
//
// https://medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
//

import Foundation

/// Code taken from https://medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
/// Overide the exec method in order to use.
open class AsyncOperation: Operation {

	public var isFinishedEvent = Event<Bool>()
	public var isExecutingEvent = Event<Bool>()

	override open var isAsynchronous: Bool {
		return true
	}

	var isFinishedInternal: Bool = false

	override open var isFinished: Bool {
		set {
			willChangeValue(forKey: "isFinished")
			isFinishedInternal = newValue
			didChangeValue(forKey: "isFinished")
			isFinishedEvent.raise(newValue)
		}

		get {
			return isFinishedInternal
		}
	}

	var isExecutingInternal: Bool = false

	override open var isExecuting: Bool {
		set {
			willChangeValue(forKey: "isExecuting")
			isExecutingInternal = newValue
			didChangeValue(forKey: "isExecuting")
			isExecutingEvent.raise(newValue)
		}

		get {
			return isExecutingInternal
		}
	}

	open func execute() {
	}

	override open func start() {
		isExecuting = true
		execute()
		isExecuting = false
		isFinished = true
	}
}
