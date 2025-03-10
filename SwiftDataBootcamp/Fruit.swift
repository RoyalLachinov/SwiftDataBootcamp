//
//  Item.swift
//  SwiftDataBootcamp
//
//  Created by Royal Lachinov on 2025-03-06.
//

import Foundation
import SwiftData

@Model
final class Fruit {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
