//
//  User.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


/// Defines the types of users in the system
enum UserType {
    case admin
    case regular
    
    /// Converts the user type to a displayable string
    /// - Throws: UserError if the role cannot be determined
    /// - Returns: String representation of the user type
    func toString() throws -> String {
        switch self {
        case .admin:
            return ("Administrador")
        case . regular:
            return ("Usuario")
        }
    }
}


enum UserError: Error {
    case invalidRole
    case invalidEmail
    case invalidUsername
    case invalidCredentials
    case unknown
    
    var description: String {
        switch self {
        case .invalidRole:
            return "No se pudo obtener el rol del usuario"
        case .invalidEmail:
            return "El email debe tener el formato xxxxx@xxxxx.zz donde zz es .es o .com"
        case .invalidUsername:
            return "El nombre debe tener entre 8 y 24 caracteres alfanuméricos"
        case .invalidCredentials:
            return "Credenciales incorrectas"
        case .unknown:
            return "Error desconocido"
        }
    }
}


/// Represents a user in the system with their credentials and type
struct User {
    /// User's full name (8-24 alphanumeric characters)
    let name: String
    /// User's email (format: xxx@xxx.es/.com)
    let email: String
    /// User's type (admin or regular)
    let password: String
    /// User's type (admin or regular)
    let type: UserType
    
    init(name: String, email: String, password: String, type: UserType) throws {
        
        //Validate username
        guard name.count >= 8 && name.count <= 24,
                name.range(of: "^[a-zA-Z0-9]+$", options: .regularExpression) != nil else {
            throw UserError.invalidUsername
        }
        
        // Validate email
        let emailRegex = "^[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.(es|com)$"
        guard email.range(of: emailRegex, options: .regularExpression) != nil else {
            throw UserError.invalidEmail
        }
        
        self.name = name
        self.email = email
        self.password = password
        self.type = type
    }
    
    func getRole() throws -> String {
        try type.toString()
    }
}
