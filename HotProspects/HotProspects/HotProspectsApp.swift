//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by saliou seck on 24/04/2024.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Prospect.self)
        }
    }
}
