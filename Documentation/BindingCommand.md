# BindingCommand

Abstract:​
Is used to give buttons and inputs actions that they will incur. Unlike the Command, this class is static.

``` swift
public final class BindingCommand
```

## Initializers

### `init(exec:undo:)`

Initializes the Command with an executable closure and a closure to undo it.

``` swift
public init(exec: @escaping () -> Bool, undo: (() -> Bool)? = nil)
```

#### Parameters

  - exec: The closure to be used for execution
  - undo: The closue to be used to undo the state changes caused by the exec closure

## Properties

### `name`

The name of the command

``` swift
var name: String?
```

## Methods

### `execute()`

Executes the command if actor is non-nil.

``` swift
@discardableResult public func execute() -> Bool
```

#### Returns

a discardable `Bool` describing if the action was successful

### `undo()`

Does the undo variant of the command if undo is set with the last value set.

``` swift
@discardableResult public func undo() -> Bool
```

#### Returns

a discardable `Bool` describing if the action was successful
