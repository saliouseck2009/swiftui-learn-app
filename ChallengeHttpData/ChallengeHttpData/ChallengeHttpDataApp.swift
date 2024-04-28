//
//  ChallengeHttpDataApp.swift
//  ChallengeHttpData
//
//  Created by saliou seck on 12/04/2024.
//

import SwiftUI
import SwiftData

@main
struct ChallengeHttpDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self)
        }
    }
}
