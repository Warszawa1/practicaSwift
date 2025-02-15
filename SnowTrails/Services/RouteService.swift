//
//  RouteService.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

class RouteService {
    private let logger = Logger.shared
    static let shared = RouteService()
    private var routes: [Route]
    private var points: [Point]
    
    private init() {
        self.points = []
        self.routes = []
        setupInitialData()
    }
    
    private func setupInitialData() {
        points = [
            Point(name: "Alpina Grande", latitude: 46.0000, longitude: 7.5000, elevation: 1500.0),
            Point(name: "Alpina Pequeña", latitude: 46.0022, longitude: 7.5200, elevation: 1200.0),
            Point(name: "Pico Nevado", latitude: 46.1000, longitude: 7.6000, elevation: 1600.0),
            Point(name: "Valle Blanco", latitude: 45.9000, longitude: 7.4000, elevation: 1400.0),
            Point(name: "Cumbre Azul", latitude: 46.0500, longitude: 7.5500, elevation: 1550.0),
            Point(name: "Lago Helado", latitude: 46.2000, longitude: 7.7000, elevation: 1700.0),
            Point(name: "Bosque Nevado", latitude: 46.3000, longitude: 7.8000, elevation: 1800.0),
            Point(name: "Cerro Plateado", latitude: 46.1500, longitude: 7.6500, elevation: 1650.0),
            Point(name: "Cascada Blanca", latitude: 46.2500, longitude: 7.7500, elevation: 1750.0),
            Point(name: "Refugio Alpino", latitude: 46.0500, longitude: 7.4500, elevation: 1450.0),
            Point(name: "Refugio Aislado", latitude: 46.0000, longitude: 7.4000, elevation: 1400.0)
        ]
        
        setupRoutes()
    }
    
    
    private func getPoints(names: [String]) -> [Point] {
        return names.compactMap { name in
            points.first { $0.name == name }
        }
    }
    
    
    private func setupRoutes() {
        routes = [
            Route(name: "Ruta del Pico Nevado y Lago Helado",
                  points: getPoints(names: ["Alpina Grande", "Pico Nevado", "Lago Helado"])),
            Route(name: "Ruta del Valle Blanco y Refugio Alpino",
                  points: getPoints(names: ["Alpina Grande", "Valle Blanco", "Refugio Alpino"])),
            Route(name: "Ruta de la Cumbre Azul y Cerro Plateado",
                  points: getPoints(names: ["Alpina Grande", "Cumbre Azul", "Cerro Plateado"])),
            Route(name: "Ruta del Bosque Nevado y Cascada Blanca",
                  points: getPoints(names: ["Lago Helado", "Bosque Nevado", "Cascada Blanca"])),
            Route(name: "Ruta del Refugio Aislado",
                  points: getPoints(names: ["Refugio Aislado"])),
            Route(name: "Ruta Alpina",
                  points: getPoints(names: ["Alpina Grande", "Alpina Pequeña"])),
            Route(name: "Ruta completa de Alpina Grande a Cascada Blanca",
                  points: getPoints(names: ["Alpina Grande", "Pico Nevado", "Lago Helado", "Bosque Nevado", "Cascada Blanca"]))
        ]
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
                let distance = calculateDistance(from: current, to: neighbor)
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
    
    private func getConnectedPoints(for point: Point) -> [Point] {
        let connections: [String: [String]] = [
            "Alpina Grande": ["Pico Nevado", "Valle Blanco", "Cumbre Azul", "Alpina Pequeña"],
            "Alpina Pequeña": ["Alpina Grande"],
            "Pico Nevado": ["Alpina Grande", "Lago Helado", "Cerro Plateado"],
            "Valle Blanco": ["Alpina Grande", "Refugio Alpino"],
            "Cumbre Azul": ["Alpina Grande", "Lago Helado", "Cerro Plateado"],
            "Lago Helado": ["Pico Nevado", "Cascada Blanca", "Cerro Plateado"],
            "Bosque Nevado": ["Pico Nevado", "Cumbre Azul", "Bosque Nevado", "Cascada Blanca"],
            "Cerro Plateado": ["Cerro Plateado", "Bosque Nevado"],
            "Cascada Blanca": ["Valle Blanco"]
        ]
        
        guard let connectedNames = connections[point.name] else {
            return []
        }
        
        return points.filter { connectedNames.contains($0.name) }
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
        // Verify points exist
        guard let start = points.first(where: { $0.name == startPointName }),
              let end = points.first(where: { $0.name == endPointName }) else {
            return nil
        }
        
        // Implementation of shortest route algorithm (Dijkstra)
        // This is the same implementation we had before
        return calculateShortestPath(from: start, to: end)
    }

    func calculateTotalDistance(for route: [Point]) -> Double {
        guard route.count > 1 else { return 0.0 }
        
        var totalDistance = 0.0
        for i in 0..<(route.count - 1) {
            totalDistance += calculateDistance(from: route[i], to: route[i + 1])
        }
        return totalDistance
    }

    private func calculateDistance(from point1: Point, to point2: Point) -> Double {
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
