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

	/// The type of the event handlers
	fileprivate typealias EventHandler = EventHandlerWrapper<DataType>
	
	/// This closure is responseible for handling the raised events data when invoked.
	public typealias Handler = (DataType) throws -> Void
	
	/// The handlers to be invoked once the event has been raised with a value
	private var eventHandlers = Set<EventHandler>()

	/// The count of the current handlers
	public var handlerCount: Int {
			eventHandlers.count
	}

	/// init
	public init() {}
	
	/// Raises the event causing all events to be called with the data from data. data is called to generate the data once per handler/listener for the event.
	/// - Parameter data: The data to pass to all events, it has the unique attribute of only being called once per handler.
	public func raise(_ data: @autoclosure () -> DataType) {
		for handler in self.eventHandlers {
			handler.invoke(data())
		}
	}

	/** Adds a handler that will be called when the event is raised.
	- Parameter target: An Object passed to the handler to act on or with, usually the interested class.
	- Parameter handler: A block of code to run with the target and data raised.
	- returns:
	A handler that allows you to manually stop listenning to the event.
	You do not need to dispose upon deint of the Target.
	*/
	public func addHandler(
		handler: @escaping Handler) -> some DisposeContainer {
		let wrapper = EventHandlerWrapper(handler: handler, event: self)
		eventHandlers.insert(wrapper)
		return DisposeContainer(toBeDisposed: wrapper)
	}
	
	/// Removes the given handler
	fileprivate func remove(handler: EventHandler) {
		eventHandlers.remove(handler)
	}

	/// deinit
	deinit {
		for handler in eventHandlers {
			handler.dispose()
		}
	}
}

/// An internal type used to wrap a handler and the event type.
private class EventHandlerWrapper<DataType>: Disposable, Identifiable {

	/// This closure is responseible for handling the events data when invoked.
	typealias Handler = (DataType) throws -> Void

	// The id of the EventHandlerWrapper used to remove itself from its event
	let id = UUID()

	/// The handler for any events that happen
	let handler: Handler
		
	/// The event the wrapper belongs too
	weak var event: Event<DataType>?
	
	/// Creates an EventHandlerWrapper with the handler to handle the invocation and the event the wrapper belongs too
	/// - Parameters:
	///   - handler: The handler to call when invoked
	///   - event: The event the EventHandlerWrapper belongs too
	init(handler: @escaping Handler, event: Event<DataType>) {
		self.handler = handler
		self.event = event
	}

	/// Invokes the handler for stored event type, disposes itself if the handler throws
	/// - Parameter data: The data to invoke the handler with
	func invoke(_ data: DataType) {
		guard (try? handler(data)) != nil else { dispose(); return }
	}

	
	/// Removes the eventhandler from its event which will allow it to deallocate
	public func dispose() {
		event?.remove(handler: self)
	}
}

extension EventHandlerWrapper: Hashable {
	
	/// - Parameters:
	///   - lhs: The left object of the comparator
	///   - rhs: The object on the right of the comparator
	/// - Returns: Wether or not the ids of the two objects match
	static func == (lhs: EventHandlerWrapper<DataType>, rhs: EventHandlerWrapper<DataType>) -> Bool {
		lhs.id == rhs.id
	}

	
	/// Creates a hash using the id
	/// - Parameter hasher: The haser to hash into
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
