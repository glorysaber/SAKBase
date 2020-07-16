//
//  Event.swift
//  SAKBase_MacOS
//
//  Created by Stephen Kac on 7/11/18.
//  Copyright © 2018 Stephen Kac. All rights reserved.
//

import Foundation

/// Provides an interface to raise events in a more performant and pure Swift manner.
/// When raising an event all handlers will be called witht data from the event.
/// If the returned DisposeContainer leaves its scope, it will remove its related event.
/// If a handle throws an error then it will also be removed silently.
public class Event<DataType> {

	fileprivate typealias EventHandler = EventHandlerWrapper<DataType>
	public typealias Handler = (DataType) throws -> Void

	fileprivate var eventHandlers = Set<EventHandler>()

	public var handlerCount: Int {
			eventHandlers.count
	}

	public init() {}

	public func raise(_ data: DataType) {
		for handler in self.eventHandlers {
			handler.invoke(data)
		}
	}

	/** Adds a handler that will be called when the event is raised.
	- Parameter target: An Object passed to the handler to act on or with, usually the interested class.
	- Parameter handler: A block of code to run with the target and data raised.
	- returns:
	A handler that allows you to manually stop listenning to the event.
	You do not need to dispose upon deint of the Target.
	*/
	@discardableResult
	public func addHandler(
		handler: @escaping Handler) -> DisposeContainer {
		let wrapper = EventHandlerWrapper(handler: handler, event: self)
		eventHandlers.insert(wrapper)
		return DisposeContainer(toBeDisposed: wrapper)
	}

	deinit {
		for handler in eventHandlers {
			handler.dispose()
		}
	}
}

private class EventHandlerWrapper<DataType>: Disposable, Identifiable {

	typealias Handler = (DataType) throws -> Void

	let id = UUID()

	let handler: Handler
	let event: Event<DataType>

	init(handler: @escaping Handler, event: Event<DataType>) {
		self.handler = handler
		self.event = event
	}

	func invoke(_ data: DataType) {
		guard (try? handler(data)) != nil else { dispose(); return }
	}

	public func dispose() {
		event.eventHandlers.remove(self)
	}
}

extension EventHandlerWrapper: Hashable {
	static func == (lhs: EventHandlerWrapper<DataType>, rhs: EventHandlerWrapper<DataType>) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
