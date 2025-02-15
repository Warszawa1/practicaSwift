//
//  App.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


final class App {
    private let mainMenu: MainMenu
    
    init() {
        self.mainMenu = MainMenu()
    }
    
    func run() {
        print("Starting SnowTrails application...")
        mainMenu.showMainMenu()
    }
}
