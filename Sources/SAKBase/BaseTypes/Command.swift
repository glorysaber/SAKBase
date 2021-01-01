//
//  Command.swift
//  Dark Ember
//
//  Created by Stephen Kac on 11/15/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//

import Foundation

/**
Abstract:
Is used to give buttons and inputs actions that they will incur.
This is helpful if you dont want to create a new command for every incurrence of the command with a different value
*/
public final class Command<ActorType: AnyObject, ValueType: Any> {

	/// The command to be executed
	private let execCommand: (ActorType, ValueType?) -> Bool

	/// The command that will undo the execCommand
	public let undoCommand: ((ActorType, ValueType?) -> Bool)?

	/// This is the value that will be used in during the exec or undo commands
	public var value: ValueType?

	/// This is the current actor the comamnds will act upon
	public weak var actor: ActorType?

	/// Initializes the Command with an executable closure and the required default values to run the command
	public convenience init(actor: ActorType?, value: ValueType?, exec: @escaping (ActorType, ValueType?) -> Bool) {
		self.init(actor: actor, value: value, exec: exec, undo: nil)
	}

	/// Initializes the Command with an executable closure and an undo closure
	public required init(
		actor: ActorType?,
		value: ValueType?,
		exec: @escaping (ActorType, ValueType?) -> Bool,
		undo: ((ActorType, ValueType?) -> Bool)?) {
		self.execCommand = exec
		self.undoCommand = undo
		self.value = value
		self.actor = actor
	}

	/**
	Executes the command with the new value if actor is non-nil.
	- Returns: a discardable `Bool` describing if the action was successful
	*/
	@discardableResult
	public func execute(with newValue: ValueType) -> Bool {
		value = newValue
		guard let actor = actor else { return false }
		return execCommand(actor, value)
	}

	/**
	Executes the command if actor is non-nil.
	- Returns: a discardable `Bool` describing if the action was successful
	*/
	@discardableResult
	public func execute() -> Bool {
		guard let actor = actor else { return false }
		return execCommand(actor, value)
	}

	/**
	Does the undo variant of the command if undo is set with the last value set.
	- Returns: a discardable `Bool` describing if the action was successful
	*/
	@discardableResult
	public func undo() -> Bool {
		guard let actor = actor else { return false }
		return undoCommand?(actor, value) ?? false
	}

	/**
	Gets a closure that can undo the last exec comamnd.
	This can be helpful in queing up a list of commands that can undo previous actions.
	- Returns: a  closure that returns bool for wether it was successful or not
	*/
	@discardableResult
	public func getUndo() -> (() -> Bool)? {
		guard let undoCommand = undoCommand else { return nil }
		return { [weak localActor = self.actor, value = self.value, undoCommand] in
			guard let actor = localActor else { return false }
			return undoCommand(actor, value)
		}
	}
}
