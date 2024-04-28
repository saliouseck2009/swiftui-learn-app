//
//  ProspectListView.swift
//  HotProspects
//
//  Created by saliou seck on 27/04/2024.
//

import SwiftUI
import SwiftData

struct ProspectListView: View {
    @Query var prospects: [Prospect]
    @Environment(\.modelContext) var modelContext
    
    
    let filter: FilterType
    
    @State private var isShowingScanner = false
    @Binding var selectedProspects : Set<Prospect>
    var body: some View {
        List(prospects, selection: $selectedProspects) { prospect in
            NavigationLink {
                EditView(prospect: prospect)
            } label:{
                HStack {
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if filter == .none {
                        prospect.isContacted
                        ? Image(systemName: "person.crop.circle.badge.checkmark")
                        : Image(systemName: "person.crop.circle.badge.minus")
                    }
                    
                    
                }
            }
            .swipeActions {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    modelContext.delete(prospect)
                }
                if prospect.isContacted {
                    Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.blue)
                } else {
                    Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                        prospect.isContacted.toggle()
                    }
                    .tint(.green)
                    Button("Remind Me", systemImage: "bell") {
                        addNotification(for: prospect)
                    }
                    .tint(.orange)
                }
            }.tag(prospect)
        }
        
    }
    
    init(filter: FilterType, sortOrder: [SortDescriptor<Prospect>], selectedProspects: Binding<Set<Prospect>>  ){
        _selectedProspects = selectedProspects
        self.filter = filter
        if filter != .none {
            let showContactedOnly = filter == .contacted
            _prospects = Query(filter: #Predicate{
                $0.isContacted == showContactedOnly
            }, sort: sortOrder)
        }
    }
    
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

}



