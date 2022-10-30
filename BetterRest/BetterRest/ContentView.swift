//
//  ContentView.swift
//  BetterRest
//
//  Created by Tianhao Liu on 10/29/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeCups = 1
    
    @State private var actualSleepAmount: Date? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When would you like to wake up?")
                DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired Amount of Sleep")
                Stepper("\(sleepAmount.simplifiedString) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                Stepper(coffeeCups == 1 ? "1 cup" : "\(coffeeCups) cups", value: $coffeeCups, in: 1...10)
                
                Text("Actual Sleep Time")
                Text("\(actualSleepAmount?.formatedHoursAndMinutes() ?? " ")")
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalc(configuration: config)
            
            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let wakeTimeInSeconds = (timeComponents.hour ?? 0) * 60 * 60 + (timeComponents.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(wakeTimeInSeconds),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeCups)
            )
            
            actualSleepAmount = wakeUp - prediction.actualSleep
        } catch {
            actualSleepAmount = nil
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
