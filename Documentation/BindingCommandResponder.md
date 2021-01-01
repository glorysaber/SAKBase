# BindingCommandResponder

Abstract:​
Used for a command responder chain in order to allow responsibility to be passed
but retain a strong reference to all captured types.

``` swift
public protocol BindingCommandResponder
```

## Requirements

### recieve(\_:​sender:​)

Called on the next responder in the chain.

``` swift
func recieve(_ command: BindingCommand, sender: Any?)
```

#### Parameters

  - command: The command to be run by the responder or to be passed to another responder in the chain
  - sender: The sender of the command
