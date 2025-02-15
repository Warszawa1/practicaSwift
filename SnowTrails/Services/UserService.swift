//
//  UserService.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

typealias LoginResult = (User) -> Void
typealias LoginError = (UserError) -> Void

class UserService {
    private let logger = Logger.shared
    static let shared = UserService()
    private var users: [User]
    
    private init() {
        // Initialize with default users using try?
        self.users = [
            try? User(name: "Adminuserkeepcoding1",
                     email: "adminuser@keepcoding.es",
                     password: "Adminuser1",
                     type: .admin),
            try? User(name: "Regularuserkeepcoding1",
                     email: "regularuser@keepcoding.es",
                     password: "Regularuser1",
                     type: .regular)
        ].compactMap { $0 } // Remove any nil values from failed initialization
    }
    
    func login(email: String,
              password: String,
              type: UserType,
              onSuccess: LoginResult,
              onFailure: LoginError) {
        logger.log("Intento de login para email: \(email), tipo: \(type)", level: .developer)
        if let user = users.first(where: { $0.email == email &&
                                          $0.password == password &&
                                          $0.type == type }) {
            onSuccess(user)
        } else {
            onFailure(.invalidCredentials)
        }
    }
    
    func addUser(name: String,
                email: String,
                password: String,
                onSuccess: @escaping LoginResult,
                onFailure: @escaping LoginError) {
        logger.log("Intentando crear nuevo usuario: \(name)", level: .developer)
        do {
            let newUser = try User(name: name,
                                 email: email,
                                 password: password,
                                 type: .regular)
            users.append(newUser)
            onSuccess(newUser)
        } catch let error as UserError {
            onFailure(error)
        } catch {
            onFailure(.unknown)
        }
    }
    
    func deleteUser(name: String) -> Bool {
        let initialCount = users.count
        users.removeAll { $0.name == name && $0.type == .regular }
        return users.count < initialCount
    }
    
    func getAllUsers() -> [User] {
        return users
    }
}
