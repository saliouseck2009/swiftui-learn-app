//
//  ContentView.swift
//  LayoutGeometry
//
//  Created by saliou seck on 04/05/2024.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                  HStack(spacing: 0) {
                      ForEach(1..<20) { num in
                          GeometryReader { proxy in
                              Text("Number \(num)")
                                  .font(.largeTitle)
                                  .padding()
                                  .background(.red)
                                  .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
                                  .frame(width: 200, height: 200)
                          }
                          .frame(width: 200, height: 200)
                      }
                  }
              }
    }
}
extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

#Preview {
    ContentView()
}
