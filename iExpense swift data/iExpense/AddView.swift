//
//  AddView.swift
//  iExpense
//
//  Created by saliou seck on 08/03/2024.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var title = "Add new expense"

    let types = ["Business", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: "XOF"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

//#Preview {
//  //  AddView(expenses: Expenses())
//}



