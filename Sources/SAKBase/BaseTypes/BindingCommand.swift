//
//  BindingCommand.swift
//  Dark Ember
//
//  Created by Stephen Kac on 5/31/17.
//  Copyright © 2017 StephenKac. All rights reserved.
//

import Foundation

/**
Abstract:
Used for a command responder chain in order to allow responsibility to be passed
but retain a strong reference to all captured types.
*/
public protocol BindingCommandResponder {
	func recieve(_ command: BindingCommand, sender: Any?)
}

/**
Abstract:
Is used to give buttons and inputs actions that they will incur. Unlike the Command, this class is static.
*/
public final class BindingCommand {

	/// The name of the command
	public var name: String?

	/// The command to be executed
	private let execCommand: () -> Bool

	/// The command that will undo the execCommand
	private let undoCommand: (() -> Bool)?

	/// Initializes the Command with an executable closure and a closure to undo it.
	public init(exec: @escaping () -> Bool, undo: (() -> Bool)? = nil ) {
		execCommand = exec
		undoCommand = undo
	}

	/**
	Executes the command if actor is non-nil.
	- Returns: a discardable `Bool` describing if the action was successful
	*/
	@discardableResult
	public func execute() -> Bool {
		return execCommand()
	}

	/**
	Does the undo variant of the command if undo is set with the last value set.
	- Returns: a discardable `Bool` describing if the action was successful
	*/
	@discardableResult
	public func undo() -> Bool {
		return undoCommand?() ?? false
	}
}
