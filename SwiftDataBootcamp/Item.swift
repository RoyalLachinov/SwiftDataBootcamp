//
//  Item.swift
//  SwiftDataBootcamp
//
//  Created by Royal Lachinov on 2025-03-06.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
