//
//  ProspectsView.swift
//  HotProspects
//
//  Created by saliou seck on 25/04/2024.
//

import SwiftUI
import SwiftData
import CodeScanner
import UserNotifications


enum FilterType: String {
    case none, contacted, uncontacted
}

struct ProspectsView: View {
    @Environment(\.modelContext) var modelContext
    @State private var isShowingScanner = false
    @State var selectedProspects = Set<Prospect>()
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }
    @State var sortOrder = [SortDescriptor<Prospect>]()

    
    var body: some View {
        NavigationStack{
                ProspectListView(filter: filter, sortOrder: sortOrder, selectedProspects: $selectedProspects)
                .navigationTitle(title)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Scan", systemImage: "qrcode.viewfinder") {
                            isShowingScanner = true
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    if selectedProspects.isEmpty == false {
                        ToolbarItem(placement: .bottomBar) {
                            Button("Delete Selected", action: delete)
                        }
                    }
                    if filter == .contacted {
                        ToolbarItem(placement: .topBarTrailing){
                            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                                Picker("Sort", selection: $sortOrder) {
                                    Text("Sort by Name")
                                        .tag([
                                            SortDescriptor(\Prospect.name),
                                        ])
                                    
                                    Text("Sort by most recent")
                                        .tag([SortDescriptor<Prospect>]())
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Saliou Seck : seydou@sen.com", completion: handleScan)
                }
        
            
    }
        
    }
    
    
    init(filter: FilterType){
        self.filter = filter
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: ":")
            guard details.count == 2 else { return }

            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)

            modelContext.insert(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
   
    
    }

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}

