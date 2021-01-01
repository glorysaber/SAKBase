# Stack

``` swift
public struct Stack<Element>
```

## Initializers

### `init()`

``` swift
public init()
```

## Properties

### `isEmpty`

``` swift
var isEmpty: Bool
```

### `count`

``` swift
var count: Int
```

### `top`

``` swift
var top: Element?
```

## Methods

### `push(_:)`

``` swift
public mutating func push(_ element: Element)
```

### `pop()`

``` swift
public mutating func pop() -> Element?
```

### `forEachPop(_:)`

``` swift
public mutating func forEachPop(_ body: (Element) throws -> Void) rethrows
```
