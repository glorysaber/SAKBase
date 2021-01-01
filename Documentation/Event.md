# Event

Provides an interface to raise events in a more performant and pure Swift manner.
When raising an event all handlers will be called witht data from the event.
If the returned DisposeContainer leaves its scope, it will remove its related event.
If a handle throws an error then it will also be removed silently.

``` swift
public class Event<DataType>
```

## Nested Type Aliases

### `Handler`

This closure is responseible for handling the raised events data when invoked.

``` swift
public typealias Handler = (DataType) throws -> Void
```

## Initializers

### `init()`

init

``` swift
public init()
```

## Properties

### `handlerCount`

The count of the current handlers

``` swift
var handlerCount: Int
```

## Methods

### `raise(_:)`

Raises the event causing all events to be called with the data from data. data is called to generate the data once per handler/listener for the event.

``` swift
public func raise(_ data: @autoclosure () -> DataType)
```

#### Parameters

  - data: The data to pass to all events, it has the unique attribute of only being called once per handler.

### `addHandler(handler:)`

Adds a handler that will be called when the event is raised.

``` swift
public func addHandler(handler: @escaping Handler) -> some DisposeContainer
```

#### Parameters

  - target: An Object passed to the handler to act on or with, usually the interested class.
  - handler: A block of code to run with the target and data raised.

#### Returns

A handler that allows you to manually stop listenning to the event. You do not need to dispose upon deint of the Target.
