//
//  Event.swift
//  SAKBase_MacOS
//
//  Created by Stephen Kac on 7/11/18.
//  Copyright © 2018 Stephen Kac. All rights reserved.
//

/// Provides an interface to raise events in a more performant and pure Swift manner. When raising an event all handlers will be called witht data from the event and if a handlers target no longer exists in memory then the handler will be removed automatically. If a handle returns false then it will also be removed.
public class Event<DataType> {
  
  fileprivate typealias EventHandler = EventHandlerWrapper<DataType>
  
  fileprivate var eventHandlers = [EventHandler]()
  
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
   A handler that allows you to manually stop listenning to the event. You do not need to dispose upon deint of the Target.
  */
	@discardableResult
  public func addHandler(_ target: AnyObject,
                         handler: @escaping (AnyObject, DataType) -> (Bool)) -> Disposable {
    let wrapper = EventHandlerWrapper(target: target,
                                      handler: handler, event: self)
    eventHandlers.append(wrapper)
    return wrapper
  }
  
  /** Adds a handler that will be called when the event is raised.
   - parameter target: An Object passed to the handler to act on or with, usually the interested class.
   - parameter handler: A function pointer that takes in a the events datatype and a handler to run it on. This will be executed when the event is raised
   - returns:
   A handler that allows you to manually stop listenning to the event. You do not need to dispose upon deint of the Target.
   **/
  public func addHandler<Target: AnyObject> (_ target: Target, handler: @escaping (Target) -> ((DataType) -> ())) -> Disposable {
    let newHandler: (AnyObject, DataType) -> (Bool) = { (target, data) in
      guard let target = target as? Target else { return false }
      handler(target)(data)
      return true
    }
    
    return addHandler(target, handler: newHandler)
  }
  
  deinit {
    for handler in eventHandlers {
      handler.dispose()
    }
  }
}

private class EventHandlerWrapper<DataType>
: Disposable {
  
  typealias Target = AnyObject
  
  weak var target: Target?
  let handler: (Target, DataType) -> (Bool)
  let event: Event<DataType>
  
  init(target: Target?, handler: @escaping (Target, DataType) -> (Bool), event: Event<DataType>) {
    self.target = target
    self.handler = handler
    self.event = event;
  }
  
  func invoke(_ data: DataType) -> () {
    guard let t = target else { dispose(); return }
    guard handler(t, data) else { dispose(); return }
  }
  
  public func dispose() {
    event.eventHandlers =
      event.eventHandlers.filter { $0 !== self }
  }
}


/// Lets you dispose of a connected type.
public protocol Disposable {
  func dispose()
}
