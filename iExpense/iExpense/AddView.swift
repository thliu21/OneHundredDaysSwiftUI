//
//  AddView.swift
//  iExpense
//
//  Created by Tianhao Liu on 11/6/22.
//

import SwiftUI

struct AddView: View {
    @Binding var isPresented: Bool
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type: ExpenseType = .personal
    
    @State private var amount = 0.0
    @State private var currencyFormatter = AdaptedCurrencyFormatter()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(ExpenseType.allCases) { item in
                            Text(item.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Amount", value: $amount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button("Submit") {
                        expenses.items.append(.init(name: name, type: type, amount: amount))
                        hideKeyboard()
                    }
                }
            }
            .navigationTitle("Add new expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isPresented = false
                } label: {
                    Text("Done")
                }
            }
        }
    }
}
