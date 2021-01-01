# Command

Abstract:​
Is used to give buttons and inputs actions that they will incur.
This is helpful if you dont want to create a new command for every incurrence of the command with a different value

``` swift
public final class Command<ActorType: AnyObject, ValueType: Any>
```

## Initializers

### `init(actor:value:exec:)`

Initializes the Command with an executable closure and the required default values to run the command

``` swift
public convenience init(actor: ActorType?, value: ValueType?, exec: @escaping (ActorType, ValueType?) -> Bool)
```

### `init(actor:value:exec:undo:)`

Initializes the Command with an executable closure and an undo closure

``` swift
public required init(actor: ActorType?, value: ValueType?, exec: @escaping (ActorType, ValueType?) -> Bool, undo: ((ActorType, ValueType?) -> Bool)?)
```

## Properties

### `undoCommand`

The command that will undo the execCommand

``` swift
let undoCommand: ((ActorType, ValueType?) -> Bool)?
```

### `value`

This is the value that will be used in during the exec or undo commands

``` swift
var value: ValueType?
```

### `actor`

This is the current actor the comamnds will act upon

``` swift
var actor: ActorType?
```

## Methods

### `execute(with:)`

Executes the command with the new value if actor is non-nil.

``` swift
@discardableResult public func execute(with newValue: ValueType) -> Bool
```

#### Returns

a discardable `Bool` describing if the action was successful

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

### `getUndo()`

Gets a closure that can undo the last exec comamnd.
This can be helpful in queing up a list of commands that can undo previous actions.

``` swift
@discardableResult public func getUndo() -> (() -> Bool)?
```

#### Returns

a  closure that returns bool for wether it was successful or not
