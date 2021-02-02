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
    @State private var wakeUp = Date()
    @State private var coffeeAmount = 1
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("When Do You Want To Wake Up?")
                    .font(.headline)
                
                DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                .labelsHidden()
                
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                
                Text("Daily Coffee Intake")
                    .font(.headline)
                Stepper(value: $coffeeAmount, in: 1...20) {
                    if coffeeAmount == 1 {
                        Text("1 Cup")
                    } else {
                        Text("\(coffeeAmount) Cups")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
