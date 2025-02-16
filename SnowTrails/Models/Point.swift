//
//  Point.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

/// Represents a geographical point in a mountain route
struct Point: Hashable {  // Hashables give something a unique "fingerprint". Used to put something in a set, find items in a collection or use something as a Dictionary key
    let name: String
    let latitude: Double
    let longitude: Double
    let elevation: Double
    
    func hash(into hasher: inout Hasher) { //'inout' means the hasher can be modified
        hasher.combine(name)
        hasher.combine(latitude)
        hasher.combine(longitude)
        hasher.combine(elevation)  //combine() adds each property to the "fingerprint"
    }
    
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.name == rhs.name &&
               lhs.latitude == rhs.latitude &&
               lhs.longitude == rhs.longitude &&
               lhs.elevation == rhs.elevation
    }
}
