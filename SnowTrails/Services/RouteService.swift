//
//  RouteService.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


/// Service responsible for managing all route-related operations in the SnowTrails application.
/// Handles route storage, calculations, and modifications.
class RouteService {
    private let logger = Logger.shared
    static let shared = RouteService()
    private var routes: [Route]
    private var points: [Point]
    
    /// Private initializer for singleton pattern
    private init() {
        self.points = []
        self.routes = []
        setupInitialData()
    }
    
    private func setupInitialData() {
        points = RouteData.points
        setupRoutes()
    }
    
    private func setupRoutes() {
        routes = RouteData.predefinedRoutes.map { name, pointNames in
            Route(name: name, points: getPoints(names: pointNames))
        }
    }
    
    private func getPoints(names: [String]) -> [Point] {
        return names.compactMap { name in
            points.first { $0.name == name }
        }
    }
    
    private func getConnectedPoints(for point: Point) -> [Point] {
        guard let connectedNames = RouteData.connections[point.name] else {
            return []
        }
        return points.filter { connectedNames.contains($0.name) }
    }
    
    private func calculateShortestPath(from start: Point, to end: Point) -> [Point]? {
        var distances: [Point: Double] = [:]
        var previousPoints: [Point: Point] = [:]
        var unvisitedPoints = Set(points)
        
        for point in points {
            distances[point] = Double.infinity
        }
        distances[start] = 0
        
        while !unvisitedPoints.isEmpty {
            guard let current = unvisitedPoints.min(by: { distances[$0] ?? Double.infinity < distances[$1] ?? Double.infinity }) else {
                break
            }
            
            if current == end {
                break
            }
            
            unvisitedPoints.remove(current)
            
            let connectedPoints = getConnectedPoints(for: current)
            for neighbor in connectedPoints where unvisitedPoints.contains(neighbor) {
                let distance = GeographyUtils.calculateDistance(from: current, to: neighbor)
                let totalDistance = (distances[current] ?? 0) + distance
                
                if totalDistance < (distances[neighbor] ?? Double.infinity) {
                    distances[neighbor] = totalDistance
                    previousPoints[neighbor] = current
                }
            }
        }
        
        var path: [Point] = []
        var current = end
        
        while current != start {
            path.insert(current, at: 0)
            guard let previous = previousPoints[current] else {
                return nil
            }
            current = previous
        }
        path.insert(start, at: 0)
        
        return path
    }
    
    func getAllRoutes() -> [Route] {
        return routes
    }
    
    func getAllPoints() -> [Point] {
        return points
    }
    
    func getFormattedRouteDescription(route: Route) -> String {
        var description = "\n\(route.name) con los siguientes puntos:"
        for point in route.points {
            description += "\n    \(point.name)"
        }
        return description
    }
    
    func displayAllRoutesWithPoints() -> String {
        var output = ""
        for route in routes {
            output += getFormattedRouteDescription(route: route)
            output += "\n"
        }
        return output
    }
    
    func addPointToRoute(routeName: String, pointName: String, position: Int) -> Bool {
        logger.log("Intentando añadir punto \(pointName) a ruta \(routeName) en posición \(position)", level: .developer)
        guard let routeIndex = routes.firstIndex(where: { $0.name == routeName }),
              let point = points.first(where: { $0.name == pointName }) else {
            return false
        }
        
        var routePoints = routes[routeIndex].points
        guard position >= 0 && position <= routePoints.count else {
            return false
        }
        
        routePoints.insert(point, at: position)
        routes[routeIndex] = Route(name: routeName, points: routePoints)
        return true
    }
    
    func getShortestRoute(from startPointName: String, to endPointName: String) -> [Point]? {
        logger.log("Buscando ruta más corta entre \(startPointName) y \(endPointName)", level: .developer)
        guard let start = points.first(where: { $0.name == startPointName }),
              let end = points.first(where: { $0.name == endPointName }) else {
            return nil
        }
        return calculateShortestPath(from: start, to: end)
    }
    
    func calculateTotalDistance(for route: [Point]) -> Double {
        guard route.count > 1 else { return 0.0 }
        
        var totalDistance = 0.0
        for i in 0..<(route.count - 1) {
            totalDistance += GeographyUtils.calculateDistance(from: route[i], to: route[i + 1])
        }
        return totalDistance
    }
}
