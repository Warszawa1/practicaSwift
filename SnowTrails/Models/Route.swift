//
//  Route.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

struct Route {
    let name: String
    let points: [Point]
    
    var distance: Double {
        guard points.count > 1 else { return 0.0 }
        
        var totalDistance = 0.0
        for i in 0..<(points.count - 1) {
            let point1 = points[i]
            let point2 = points[i + 1]
            totalDistance += calculateDistance(from: point1, to: point2)
        }
        
        return totalDistance
    }
}

// Helper function to calculate distance between two points
func calculateDistance(from point1: Point, to point2: Point) -> Double {
    let R = 6371.0 // Earth's radius in kilometers
    
    let lat1 = point1.latitude * .pi / 180
    let lat2 = point2.latitude * .pi / 180
    let deltaLat = (point2.latitude - point1.latitude) * .pi / 180
    let deltaLon = (point2.longitude - point1.longitude) * .pi / 180
    
    let a = sin(deltaLat/2) * sin(deltaLat/2) +
            cos(lat1) * cos(lat2) *
            sin(deltaLon/2) * sin(deltaLon/2)
    
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    return R * c
}
