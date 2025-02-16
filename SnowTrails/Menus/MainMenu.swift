//
//  MainMenu.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


/// Main menu controller handling initial user interaction
class MainMenu {
    private let userService = UserService.shared
    private let logger = Logger.shared
    
    
    /// Shows the main menu and handles user selection
    /// Entry point for user interaction with the application
    func showMainMenu() {
        logger.log("Iniciando menú principal", level: .developer)
        print("""
            
                                        ❄️🏔️🥾 Bienvenido a 
            
               ███████╗███╗   ██╗ ██████╗ ██╗    ██╗████████╗██████╗  █████╗ ██╗██╗     ███████╗
               ██╔════╝████╗  ██║██╔═══██╗██║    ██║╚══██╔══╝██╔══██╗██╔══██╗██║██║     ██╔════╝
               ███████╗██╔██╗ ██║██║   ██║██║ █╗ ██║   ██║   ██████╔╝███████║██║██║     ███████╗
               ╚════██║██║╚██╗██║██║   ██║██║███╗██║   ██║   ██╔══██╗██╔══██║██║██║     ╚════██║
               ███████║██║ ╚████║╚██████╔╝╚███╔███╔╝   ██║   ██║  ██║██║  ██║██║███████╗███████║
               ╚══════╝╚═╝  ╚═══╝ ╚═════╝  ╚══╝╚══╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
                                                                                                
            """)
        while true {
            print("1. Acceder como usuario")
            print("2. Acceder como administrador")
            print("3. Salir")
            print("> ", terminator: "")
            
            if let choice = readLine(), let option = Int(choice) {
                switch option {
                case 1:
                    handleUserLogin()
                case 2:
                    handleAdminLogin()
                case 3:
                    print("¡Hasta luego!")
                    exit(0)
                default:
                    print("Opción no válida")
                }
            }
        }
    }
    
    
    private func handleUserLogin() {
        logger.log("Intento de login como usuario normal", level: .developer)
        print("\nIntroduce tu email:")
        print("> ", terminator: "")
        guard let email = readLine() else { return }
        
        
        guard Validator.validateEmail(email) else {
            print("\nError: \(ValidationError.invalidEmail.description)")
            return
        }
        
        print("Introduce tu contraseña:")
        print("> ", terminator: "")
        guard let password = readLine() else { return }
            
        // Verify regular user credentials
        userService.login(
            email: email,
            password: password,
            type: .regular,
            onSuccess: { user in
                do {
                    let role = try user.getRole()
                    print("\nBienvenido! Accediendo como \(role)")
                    let userMenu = UserMenu(user: user)
                    userMenu.showMenu()
                } catch {
                    print("\nError al obtener el rol del usuario")
                }
            },
            onFailure: { error in
                print("\n\(error.description)")
            }
        )
    }

    
    private func handleAdminLogin() {
        logger.log("Intento de login como administrador", level: .developer)
        print("\nIntroduce tu email:")
        print("> ", terminator: "")
        guard let email = readLine() else { return }
        
        guard Validator.validateEmail(email) else {
            print("\nError: \(ValidationError.invalidEmail.description)")
            return
        }
        
        print("Introduce tu contraseña:")
        print("> ", terminator: "")
        guard let password = readLine() else { return }
           
        // Verify admin user credentials
        userService.login(
            email: email,
            password: password,
            type: .admin,
            onSuccess: { user in
                do {
                    let role = try user.getRole()
                    print("\nBienvenido! Accediendo como \(role)")
                    let adminMenu = AdminMenu(admin: user)
                    adminMenu.showMenu()
                } catch {
                    print("\nError al obtener el rol del usuario")
                }
            },
            onFailure: { error in
                print("\n\(error.description)")
            }
        )
    }
}
