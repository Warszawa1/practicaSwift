//
//  User.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

enum UserType {
    case admin
    case regular
    
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


struct User {
    let name: String
    let email: String
    let password: String
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
