//
//  ContentView.swift
//  iExpense
//
//  Created by saliou seck on 04/03/2024.
//

import SwiftUI
import Observation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
   // @State private var showingAddExpense = false
    
   
    var body: some View {
        NavigationStack{
            List {
                ForEach(expenses.items){ item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "SN"))
                            .valueStyle(color:item.amount<=10 ? Color.red : (item.amount <= 100 ? Color.orange : Color.green) )
                        }
                    
                }.onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar(content: {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Button("Add Expense", systemImage: "plus"){
                       
                    }
                }
                
            })
//            .sheet(isPresented: $showingAddExpense, content: {
//                AddView(expenses: expenses)
//            })
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    
   
}

struct UnderTenModifier: ViewModifier{
    let color : Color
    func body(content: Content) -> some View {
        content
            .font(.headline.bold())
            .foregroundColor(color)
            
    }
}

extension View {
    func valueStyle(color: Color) -> some View {
        modifier(UnderTenModifier(color: color))
    }
}

#Preview {
    ContentView()
}
