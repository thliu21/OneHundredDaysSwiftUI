//
//  ContentView.swift
//  WeSplit
//
//  Created by Tianhao Liu on 10/15/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    private enum TipAmount: Int, CaseIterable, Equatable {
        case zero = 0
        case ten = 10
        case fifteen = 15
        case twenty = 20
        case twentyFive = 25
    }
    
    private static var minPeopleToSplit = 2
    
    @State private var checkAmount = 0.0
    @State private var numOfPeopleSelectIndex = 0
    @State private var tipAmount: TipAmount = .ten
    
    private var numOfPeople: Int {
        numOfPeopleSelectIndex + Self.minPeopleToSplit
    }
    
    private var total: Double {
        checkAmount * (1.0 + Double(tipAmount.rawValue) / 100.0)
    }
    
    private var totalPerPerson: Double {
        total / Double(numOfPeople)
    }
    
    private var formatter = AdaptedCurrencyFormatter()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Total Amount", value: $checkAmount, formatter: formatter)
                            .keyboardType(.decimalPad)
                    }
                    Picker("Number of people", selection: $numOfPeopleSelectIndex) {
                        ForEach(2 ..< 11) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tips", selection: $tipAmount) {
                        ForEach(TipAmount.allCases, id: \.self) { value in
                            if #available(iOS 15.0, *) {
                                Text(value.rawValue, format: .percent)
                            } else {
                                Text("\(value.rawValue)%")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tips")
                }
                
                Section {
                    Text(formatter.string(for: total) ?? "$0.0")
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(formatter.string(for: totalPerPerson) ?? "$0.0")
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
