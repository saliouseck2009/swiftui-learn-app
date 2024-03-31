//
//  BookwormApp.swift
//  Bookworm
//
//  Created by saliou seck on 30/03/2024.
//

import SwiftData
import SwiftUI


@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Book.self)
    }
}
