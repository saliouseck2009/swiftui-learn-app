//
//  RessortDetailView.swift
//  SnowSeeker
//
//  Created by saliou seck on 11/05/2024.
//

import SwiftUI

struct RessortDetailView: View {
    let resort: Resort
    var size: String {
        switch resort.size {
        case 1: "Small"
        case 2: "Average"
        default: "Large"
        }
    }
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    var body: some View {
        Group {
               VStack {
                   Text("Size")
                       .font(.caption.bold())
                   Text(size)
                       .font(.title3)
               }

               VStack {
                   Text("Price")
                       .font(.caption.bold())
                   Text(price)
                       .font(.title3)
               }
           }
           .frame(maxWidth: .infinity)
    }
}

#Preview {
    RessortDetailView(resort: .example)
}
