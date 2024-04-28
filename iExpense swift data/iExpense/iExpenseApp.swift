//
//  iExpenseApp.swift
//  iExpense
//
//  Created by saliou seck on 04/03/2024.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ExpenseItem.self)
        }
    }
}
