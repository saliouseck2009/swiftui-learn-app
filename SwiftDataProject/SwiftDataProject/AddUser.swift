//
//  AddUser.swift
//  SwiftDataProject
//
//  Created by saliou seck on 02/04/2024.
//

import SwiftUI
import SwiftData

struct AddUser: View {
    @Bindable var user: User
    var body: some View {
        Form{
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "", city: "", joinDate: .now)
     return    AddUser(user: user)
            .modelContainer(container)
    }catch{
      return   Text("Error when configuring data")
    }
}
