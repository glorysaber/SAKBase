# AsyncOperation

Code taken from https:​//medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
Overide the exec method in order to use.

``` swift
open class AsyncOperation: Operation
```

## Inheritance

`Operation`

## Properties

### `isFinishedEvent`

``` swift
var isFinishedEvent
```

### `isExecutingEvent`

``` swift
var isExecutingEvent
```

### `isAsynchronous`

``` swift
var isAsynchronous: Bool
```

### `isFinished`

``` swift
var isFinished: Bool
```

### `isExecuting`

``` swift
var isExecuting: Bool
```

## Methods

### `execute()`

``` swift
open func execute()
```

### `start()`

``` swift
override open func start()
```
