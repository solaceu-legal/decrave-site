//
//  Item.swift
//  SlipEasy
//
//  Created by 王晓航 on 2026/8/15.
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
