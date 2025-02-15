//
//  Point.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

struct Point: Hashable {
    let name: String
    let latitude: Double
    let longitude: Double
    let elevation: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(latitude)
        hasher.combine(longitude)
        hasher.combine(elevation)
    }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.name == rhs.name &&
               lhs.latitude == rhs.latitude &&
               lhs.longitude == rhs.longitude &&
               lhs.elevation == rhs.elevation
    }
}
