//
//  ContentView.swift
//  BetterRest
//
//  Created by Travis Brigman on 2/1/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    //alert variables
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header:Text("When Do You Want To Wake Up?").font(.headline)) {
                    
                    DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired Amount of Sleep")
                    .font(.headline)) {
                        
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                }
                
                Section(header: Text("Daily Coffee Intake")
                    .font(.headline)) {
                        Picker("Coffe Cups",selection: $coffeeAmount) {
                            ForEach(1..<21, id: \.self){i in
                                Text("\(i)")
                            }
                        }
                }
                Section(header: Text("your recommended bed time:").font(.headline)){
                Text(calculateBedTime)
                    .font(.largeTitle)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    

    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    var calculateBedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        var bedTimeMessage = ""
        
        do{
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            bedTimeMessage = formatter.string(from: sleepTime)
            alertTitle = "Your Bedtime Is:"
        } catch {
            alertTitle = "Error"
            bedTimeMessage = "There was a problem calculating your bed time"
        }
        return bedTimeMessage
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
