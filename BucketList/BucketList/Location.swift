//
//  Location.swift
//  BucketList
//
//  Created by Arthur Liu on 1/19/23.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
