//
//  ContentView.swift
//  Tryout
//
//  Created by Tianhao Liu on 10/28/22.
//

import SwiftUI
import Focuser

#if canImport(UIKit)
extension View {
   func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
} }
#endif

struct ContentView: View {
    @State private var tipAmount: String = "10"
    
    var body: some View {
        VStack {
            TextField("Tip Amount ", text: $tipAmount)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.decimalPad)
            Button("Submit") {
                print("Tip: \(tipAmount)")
                hideKeyboard()
            }
        }
    }
}
