//
//  UserMenu.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


/// Menu interface for regular users of the SnowTrails application.
/// Provides access to route viewing and shortest path calculation features.
class UserMenu {
    /// The authenticated user for this menu session
    private let user: User
    private let userService = UserService.shared
    /// Service handling all route-related operations
    private let routeService = RouteService.shared
    
    /// Initializes a new user menu session
    /// - Parameter user: The authenticated user accessing the menu
    init(user: User, routes: [Route] = []) {
        self.user = user
    }
    
    /// Displays the main user menu and handles user input
    func showMenu() {
        while true {
            print("\nMenú usuario - Selecciona una opción:")
            print("1. Ver todas las rutas")
            print("2. Obtener la ruta más corta entre dos puntos")
            print("3. Log out")
            print("> ", terminator: "")
            
            if let choice = readLine(), let option = Int(choice) {
                switch option {
                case 1:
                    showAllRoutes()
                case 2:
                    findShortestRoute()
                case 3:
                    print("\nCerrando sesión...")
                    return
                default:
                    print("\nOpción no válida")
                }
            }
        }
    }
    
    
    /// Displays all available routes with their distances
    private func showAllRoutes() {
        print("\nRutas disponibles:")
        let routes = routeService.getAllRoutes()
        for route in routes {
            print("\(route.name) - \(String(format: "%.2f", route.distance)) km")
        }
    }
    
    
    /// Handles the shortest route calculation between two points
    /// Shows available routes, takes user input for start and end points,
    /// and displays the calculated shortest path if found
    private func findShortestRoute() {
        // First display all routes and their points
        print("\nRutas disponibles y sus puntos:")
        print(routeService.displayAllRoutesWithPoints())
        
        print("\nIntroduce el nombre del punto de inicio:")
        print("> ", terminator: "")
        guard let startPoint = readLine() else { return }
        
        // Display routes again for end point selection
        print("\nRutas disponibles y sus puntos:")
        print(routeService.displayAllRoutesWithPoints())
        
        print("\nIntroduce el nombre del punto de destino:")
        print("> ", terminator: "")
        guard let endPoint = readLine() else { return }
        
        // Validate points are different
        guard startPoint != endPoint else {
            print("\nError: El punto de inicio y destino deben ser diferentes")
            return
        }
        
        if let route = routeService.getShortestRoute(from: startPoint, to: endPoint) {
            let distance = routeService.calculateTotalDistance(for: route)
            print("\nLa distancia más corta entre \(startPoint) y \(endPoint) es: \(String(format: "%.2f", distance)) km.")
            print("La ruta es:")
            for point in route {
                print("    \(point.name)")
            }
        } else {
            print("\nNo se encontró una ruta entre estos puntos")
        }
    }
    
    
}
