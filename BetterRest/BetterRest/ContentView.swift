//
//  ContentView.swift
//  BetterRest
//
//  Created by saliou seck on 01/02/2024.
//
import CoreML
import SwiftUI

struct CustomText : View{
    var text : String
    var body: some View{
        Text(text)
    }
}

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var showingAlert = false

    var sleepTime : String {
        calculateBedtime()
    }

    private var desiredSleepAmountRanges = Array(stride(from: 4, to: 12, by: 0.25))
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack{
            Form {
                Section("When do you want to wake up?"){
                        DatePicker("Time to wake up", selection: $wakeUp , displayedComponents: .hourAndMinute)
                            .labelsHidden()
                           // .datePickerStyle(.wheel)
                            .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                    Section("Desired amount of sleep"){
                       
                        Picker("\(sleepAmount.formatted()) hours",selection: $sleepAmount){
                            ForEach(desiredSleepAmountRanges, id: \.self){
                                Text("\($0, specifier: "%.2f") hours")
                            }
                        }.pickerStyle(.wheel)
                    }
                        Section("Daily coffee intake"){
                            Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                        }
                Section("Calculated BedTime") {
                    CustomText(text :sleepTime)
                }
           }
            .navigationTitle("BetterRest")

        }
    }
    
    func calculateBedtime()  -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Int64(Double(hour + minute)), estimatedSleep: sleepAmount, coffee: Int64(Double(coffeeAmount)))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
           
            let alertMessage = "Sorry, there was a problem calculating your bedtime."
            return alertMessage
        }
    }
 
}

enum ModelError : Error {
    case gettingModelError
}

#Preview {
    ContentView()
}
