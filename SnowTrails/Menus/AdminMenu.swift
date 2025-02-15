//
//  AdminMenu.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


class AdminMenu {
    private let admin: User
    private let userService = UserService.shared
    private let routeService = RouteService.shared

    
    init(admin: User) {
        self.admin = admin
    }
    
    func showMenu() {
        while true {
            print("\nMenú admin - Selecciona una opción:")
            print("1. Ver todos los usuarios")
            print("2. Añadir usuario")
            print("3. Eliminar usuario")
            print("4. Añadir punto a una ruta")
            print("5. Logout")
            print("> ", terminator: "")
            
            if let choice = readLine(), let option = Int(choice) {
                switch option {
                case 1:
                    showAllUsers()
                case 2:
                    addUser()
                case 3:
                    deleteUser()
                case 4:
                    addPointToRoute()
                case 5:
                    print("\nCerrando sesión...")
                    return
                default:
                    print("\nOpción no válida")
                }
            }
        }
    }
    
    private func showAllUsers() {
        print("\nUsuarios registrados:")
        let users = userService.getAllUsers()
        for user in users {
            let userType = user.type == .admin ? "Admin" : "Regular user"
            print("\(userType): \(user.name) --- Email: \(user.email)")
        }
    }
    
    private func addUser() {
        print("\nIntroduce el nombre del usuario que quieres añadir")
        print("> ", terminator: "")
        guard let name = readLine() else { return }
        
        print("Introduce el email del usuario que quieres añadir")
        print("> ", terminator: "")
        guard let email = readLine() else { return }
        
        print("Introduce la contraseña del usuario que quieres añadir")
        print("> ", terminator: "")
        guard let password = readLine() else { return }
        
        userService.addUser(
            name: name,
            email: email,
            password: password,
            onSuccess: { user in
                print("\nUsuario \(user.name) con email \(user.email) añadido satisfactoriamente")
            },
            onFailure: { error in
                print("\nError: \(error.description)")
            }
        )
    }
    
    private func deleteUser() {
        print("\nIntroduce el nombre del usuario que quieres eliminar:")
        print("> ", terminator: "")
        guard let name = readLine() else { return }
        
        
        if userService.deleteUser(name: name) {
            print("\nUsuario(s) eliminado(s) satisfactoriamente")
        } else {
            print("\nNo se encontró ningún usuario con ese nombre")
        }
    }
    
    private func addPointToRoute() {
        print("\nRutas disponibles:")
        print(routeService.displayAllRoutesWithPoints())
        
        print("\nIntroduce el nombre de la ruta:")
        print("> ", terminator: "")
        guard let routeName = readLine() else { return }
        
        print("\nPuntos disponibles:")
        let points = routeService.getAllPoints()
        for point in points {
            print("- \(point.name)")
        }
        
        print("\nIntroduce el nombre del punto a añadir:")
        print("> ", terminator: "")
        guard let pointName = readLine() else { return }
        
        print("\nIntroduce la posición donde añadir el punto (0 para inicio, 1 para segundo lugar, etc):")
        print("> ", terminator: "")
        guard let positionStr = readLine(), let position = Int(positionStr) else { return }
        
        if routeService.addPointToRoute(routeName: routeName, pointName: pointName, position: position) {
            print("\nPunto añadido correctamente a la ruta")
        } else {
            print("\nError: No se pudo añadir el punto a la ruta")
        }
    }
}
