# Types

  - [BindingCommand](./BindingCommand.md):
    Abstract:
    Is used to give buttons and inputs actions that they will incur. Unlike the Command, this class is static.
  - [Command](./Command.md):
    Abstract:
    Is used to give buttons and inputs actions that they will incur.
    This is helpful if you dont want to create a new command for every incurrence of the command with a different value
  - [DisposeContainer](./DisposeContainer.md):
    Automatically disposes of a event upon deinit
  - [Event](./Event.md):
    Provides an interface to raise events in a more performant and pure Swift manner.
    When raising an event all handlers will be called witht data from the event.
    If the returned DisposeContainer leaves its scope, it will remove its related event.
    If a handle throws an error then it will also be removed silently.
  - [Stack](./Stack.md)
  - [AsyncOperation](./AsyncOperation.md):
    Code taken from https://medium.com/flawless-app-stories/parallel-programming-with-swift-operations-54cbefaf3cb0
    Overide the exec method in order to use.
  - [GroupOperation](./GroupOperation.md)
  - [PThread](./PThread.md):
    Contains wrapper types for C pthread operations
  - [PThread.ReadWriteLock](./PThread_ReadWriteLock.md):
    Wrapper for pthread\_rwlock\_t

# Protocols

  - [BindingCommandResponder](./BindingCommandResponder.md):
    Abstract:
    Used for a command responder chain in order to allow responsibility to be passed
    but retain a strong reference to all captured types.
  - [Disposable](./Disposable.md):
    Lets you dispose of a connected type.
  - [Point](./Point.md):
    A Swift protocol for a point in some 2 dimensional container
  - [Point3](./Point3.md):
    A Swift protocol for a point in some 2 dimensional container
  - [EquivalentIntegerSize](./EquivalentIntegerSize.md)
  - [ProgressReporting](./ProgressReporting.md)

# Operators

  - [+(lhs:​rhs:​)](./+\(lhs:rhs:\).md)
  - [-(lhs:​rhs:​)](./-\(lhs:rhs:\).md)
  - [\*(lhs:​rhs:​)](./*\(lhs:rhs:\).md)
  - [+(lhs:​rhs:​)](./+\(lhs:rhs:\).md)
  - [-(lhs:​rhs:​)](./-\(lhs:rhs:\).md)
  - [\*(lhs:​rhs:​)](./*\(lhs:rhs:\).md)
  - [\!\!(wrapped:​failureText:​)](./!!\(wrapped:failureText:\).md):
    Allows an error message to be states with a failed force unwrap of an optional

# Global Functions

  - [strongify(*:​*:​)](./strongify\(_:_:\).md):
    Takes a target and strongly captures it and runs the given closure body against it.
  - [strongify(*:​*:​)](./strongify\(_:_:\).md):
    Takes a target and strongly captures it and runs the given closure body against it.
  - [strongify(*:​*:​)](./strongify\(_:_:\).md):
    Takes a target and strongly captures it and runs the given closure body against it.
  - [strongify(*:​*:​)](./strongify\(_:_:\).md):
    Takes a target and strongly captures it and runs the given closure body against it.
  - [unsafeWeakify(*:​*:​)](./unsafeWeakify\(_:_:\).md):
    Takes a target and unsafely runs the given closure against it as if the target is unowned.
  - [unsafeWeakify(*:​*:​)](./unsafeWeakify\(_:_:\).md):
    Takes a target and unsafely runs the given closure against it as if the target is unowned.
  - [unsafeWeakify(*:​*:​)](./unsafeWeakify\(_:_:\).md):
    Takes a target and unsafely runs the given closure against it as if the target is unowned.
  - [weakify(*:​default:​*:​)](./weakify\(_:default:_:\).md):
    Takes a target and weakly runs the given closure against it
    Return the default value if nil.
  - [weakify(*:​*:​)](./weakify\(_:_:\).md):
    Takes a target and weakly runs the given closure against it.
    If nil, does nothing.
  - [weakify(*:​*:​)](./weakify\(_:_:\).md):
    Takes a target and weakly runs the given closure against it.
    If nil, does nothing.
  - [weakify(*:​default:​*:​)](./weakify\(_:default:_:\).md):
    Takes a target and weakly runs the given closure against it.
    If nil, does nothing.
  - [weakify(*:​default:​*:​)](./weakify\(_:default:_:\).md):
    Takes a target and weakly runs the given closure against it.
    If nil, does nothing.
  - [weakify(*:​default:​*:​)](./weakify\(_:default:_:\).md):
    Takes a target and weakly runs the given closure against it
    Return the default value if nil. If default value is not given, nil will be returned isntead.
