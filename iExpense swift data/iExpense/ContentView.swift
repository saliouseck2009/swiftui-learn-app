//
//  ContentView.swift
//  iExpense
//
//  Created by saliou seck on 04/03/2024.
//

import SwiftUI
import Observation
import SwiftData

@Model
class ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    init( name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

struct ExpenseListView : View {
    @Query var expenses : [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], filter: ExpenseType){
        let filtername = filter.rawValue.description
        if (filter == .all){
            _expenses = Query(sort :sortOrder)
        }else{
            _expenses = Query(filter: #Predicate<ExpenseItem> {expense in
                expense.type.contains(filtername)
            }, sort: sortOrder)
        }
        
    }
    var body: some View{
        List {
            ForEach(expenses){ item in
                HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "SN"))
                        .valueStyle(color: Color.black) //item.amount<=10 ? Color.red : (item.amount <= 100 ? Color.orange : Color.green) )
                    }
                
            }.onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet){
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
    
    
}

enum ExpenseType : String,CaseIterable {
    case personal = "Personal"
    case bussiness = "Business"
    case all = "All"
}

struct ContentView: View {
    @Query var expenses : [ExpenseItem]
    @Environment(\.modelContext) var modelContext
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    @State private var showPersonal = true
    @State private var showBussiness = true
    @State private var expensesType : ExpenseType = .all
   
    var body: some View {
        NavigationStack{
          
            ExpenseListView(sortOrder: sortOrder, filter :expensesType)
                .navigationTitle("iExpense")
                .toolbar(content: {
                    ToolbarItemGroup{
                            NavigationLink {
                                
                                AddView()
                            } label: {
                                Button("Add Expense", systemImage: "plus"){
                                    
                                }
                            }
                        
                        
                        
                        Menu("Sort", systemImage: "arrow.up.arrow.down"){
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort By Name").tag(
                                    [
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.amount)
                                    ]
                                )
                                Text("Sort By Amount").tag(
                                    [
                                        SortDescriptor(\ExpenseItem.amount),
                                        SortDescriptor(\ExpenseItem.name),
                                    ]
                                )
                                
                            }
                        }
                        Menu("Sort", systemImage: "line.horizontal.3.decrease.circle"){
                            Picker("Sort", selection:$expensesType ) {
                                ForEach(ExpenseType.allCases, id: \.self){ type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                        }
                    }
                
                
            })
//            .sheet(isPresented: $showingAddExpense, content: {
//                AddView(expenses: expenses)
//            })
        }
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
