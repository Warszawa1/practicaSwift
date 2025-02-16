//
//  GeographyUtils.swift
//  SnowTrails
//
//  Created by Ire  Av on 16/2/25.
//

import Foundation


/// Utility functions for geographical calculations
struct GeographyUtils {
    /// Calculates the geographical distance between two points using the Haversine formula
    /// - Parameters:
    ///   - point1: Starting point with coordinates
    ///   - point2: Ending point with coordinates
    /// - Returns: Distance in kilometers
    static func calculateDistance(from point1: Point, to point2: Point) -> Double {
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
}
