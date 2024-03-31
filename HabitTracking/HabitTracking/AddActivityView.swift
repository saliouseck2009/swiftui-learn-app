//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by saliou seck on 24/03/2024.
//

import SwiftUI

struct AddActivityView: View {
    var activity : Activity
    @Environment(\.dismiss) var dismiss
    @State var name : String = ""
    @State var description : String = ""
    @State private var selectedColor = Color.yellow
    var body: some View {
       
        NavigationStack {
            Form(){
                Section("Info"){
                    TextField("Name", text: $name )
                    TextField("Description", text: $description)
                    
                }
                Section(header: Text("Color Picker")) {
                                   ColorPicker("Select a color", selection: $selectedColor)
                                       .padding()
                               }
            }
            .navigationTitle("Add Activity")
            .toolbar(content: {
                Button{
                    activity.activities.append(ActivityItem(name: name, description: description, color: selectedColor))
                    dismiss()
                }label: {
                    Label("Add Activity", systemImage: "plus")
                }
            })
        }
    }
}

#Preview {
    AddActivityView(activity: Activity())
}
