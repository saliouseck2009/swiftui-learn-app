//
//  ContentView.swift
//  BucketList
//
//  Created by saliou seck on 18/04/2024.
//

import SwiftUI
import MapKit
struct ContentView: View {
    
   @State private var viewModel = ViewModel()
   
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
               
                MapReader { proxy in
                    Map(initialPosition: viewModel.startPosition){
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate){
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 30, height: 30)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                    }.mapStyle(viewModel.mapStyle)
                    .onTapGesture {position in
                        if let coordinate = proxy.convert(position, from: .local){
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) { newLocation in
                            viewModel.updateLocation(location: newLocation)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Picker("Select Style",selection: $viewModel.selectedStyle){
                            ForEach(viewModel.styles, id:\.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                        .font(.title)
                        .foregroundStyle(.white)
                        .onChange(of: viewModel.selectedStyle, { oldValue, newValue in
                            viewModel.switchMapStyle()
                        })
                    .frame(width:200)
                    .padding()
                    }
                }
                
            }
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
                .alert("Authentication Failed ", isPresented: $viewModel.showAlert){
                } message: {
                    Text(viewModel.authErrorMessage)
                }
        }
            
        
    }
    
    
    
}

#Preview {
    ContentView()
}
