//
//  ContentView.swift
//  BetterRest
//
//  Created by Tianhao Liu on 10/29/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp: Date = {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @State private var sleepAmount = 8.0
    @State private var coffeeCups = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("When would you like to wake up?").font(.headline)
                        DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Desired Amount of Sleep").font(.headline)
                        Stepper("\(sleepAmount.simplifiedString) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Daily coffee intake").font(.headline)
                        Stepper(coffeeCups == 1 ? "1 cup" : "\(coffeeCups) cups", value: $coffeeCups, in: 1...10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Actual Sleep Time").font(.headline)
                        Text("\(Self.calculateBedtime(wakeUp: wakeUp, sleepAmount: sleepAmount, coffeeCups: coffeeCups)?.formatedHoursAndMinutes() ?? " ")")
                            .font(.system(size: 30, weight: .bold))
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

extension ContentView {
    static func calculateBedtime(wakeUp: Date, sleepAmount: Double, coffeeCups: Int) -> Date? {
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
            
            return wakeUp - prediction.actualSleep
        } catch {
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
