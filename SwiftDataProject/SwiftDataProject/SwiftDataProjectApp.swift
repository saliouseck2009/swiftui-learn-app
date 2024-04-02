//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by saliou seck on 02/04/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
