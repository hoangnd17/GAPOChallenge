//
//  Reusable.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import Foundation
import UIKit

public protocol Reusable: AnyObject {
  /// The reuse identifier to use when registering and later dequeuing a reusable cell
  static var reuseIdentifier: String { get }
}

public extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

extension UITableViewCell: Reusable { }
