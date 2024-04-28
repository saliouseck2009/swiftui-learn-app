//
//  EditView.swift
//  HotProspects
//
//  Created by saliou seck on 27/04/2024.
//

import SwiftUI
import SwiftData

struct EditView: View {
    @Environment(\.dismiss) var dissmiss
    @Bindable var prospect: Prospect
    var body: some View {
        Form{
            TextField("Name", text: $prospect.name )
            TextField("Email", text: $prospect.emailAddress)
        }
        .navigationTitle("Edit Prospect")
        .toolbar(content: {
            Button("Save"){
                dissmiss()
            }
        })
    }
    
}

#Preview {
    EditView(prospect: Prospect.sampleProspect)
        .modelContainer(for: Prospect.self)
}
