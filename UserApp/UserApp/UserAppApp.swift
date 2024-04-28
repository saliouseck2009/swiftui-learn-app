//
//  UserAppApp.swift
//  UserApp
//
//  Created by saliou seck on 14/04/2024.
//

import SwiftUI
import SwiftData

@main
struct UserAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
