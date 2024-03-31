//
//  ContentView.swift
//  Conversion
//
//  Created by saliou seck on 24/01/2024.
//

import SwiftUI


struct ContentView: View {
    @State private var value  = 0.0
    @State private var from = "hours"
    @State private var to = "seconds"
    private var conversionItems = ["seconds", "minutes", "hours", "days"]
    private var conversionItemsMap = ["seconds" : 1, "minutes": 60, "hours":3600, "days":86400]
    var result : Double {
        let resultValue = value * Double(conversionItemsMap[from, default: 1])
        return resultValue / Double(conversionItemsMap[to, default: 1])
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("From"){
                    Picker("From", selection: $from ){
                        ForEach(conversionItems,id:  \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("To"){
                    Picker("To", selection: $to ){
                        ForEach(conversionItems,id:  \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Entrer la valeur à convertir"){
                    TextField("Valeur à convertir",
                              value: $value, 
                              format: .number)
                    .keyboardType(.decimalPad)
                }
                Section("Résultat") {
                    Text(result, format: .number)
                }
                
            }.navigationTitle("Conversion")
        }
    }
}

#Preview {
    ContentView()
}
