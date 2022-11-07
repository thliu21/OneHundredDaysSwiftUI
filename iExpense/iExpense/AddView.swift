//
//  AddView.swift
//  iExpense
//
//  Created by Tianhao Liu on 11/6/22.
//

import SwiftUI

struct AddView: View {
    @Binding var isPresented: Bool
    
    @State private var name = ""
    @State private var type = "Personal"
    
    @State private var amount = 0.0
    @State private var currencyFormatter = AdaptedCurrencyFormatter()

    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Submit") {
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
