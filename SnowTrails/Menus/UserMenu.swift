//
//  UserMenu.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

class UserMenu {
    private let user: User
    private let userService = UserService.shared
    private let routeService = RouteService.shared
    
    
    init(user: User, routes: [Route] = []) {
        self.user = user
    }
    
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
    
    private func showAllRoutes() {
        print("\nRutas disponibles:")
        let routes = routeService.getAllRoutes()
        for route in routes {
            print("\(route.name) - \(String(format: "%.2f", route.distance)) km")
        }
    }
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
