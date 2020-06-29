//
//  UniversalEntityInfo.swift
//  Dark Ember
//
//  Created by Stephen Kac on 12/29/16.
//  Copyright © 2016 StephenKac. All rights reserved.
//

import Foundation

public typealias Identifier = String

public protocol Identifiable {
  var universalID: String {get}
}

public fileprivate(set) var universalObjectID = UniversalID()

final public class UniversalID: Codable {
  public private(set) var ids: Set<Identifier>
  
  public func nextID() -> Identifier {
    while(true) {
      let id = UUID().uuidString
      if !ids.contains(id) {
        ids.insert(id)
        return id
      }
    }
  }
  
  public func remove(id: Identifier) {
    ids.remove(id)
  }
  
  public init(ids: Set<Identifier> = Set<Identifier>()) {
    self.ids = ids
  }
  
}
