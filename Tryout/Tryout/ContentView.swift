//
//  ContentView.swift
//  Tryout
//
//  Created by Tianhao Liu on 10/28/22.
//

import SwiftUI
import SwipeCell

#if canImport(UIKit)
extension View {
   func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
} }
#endif

struct ContentView: View {
    @State private var numbers = [5, 6, 7, 8]
    
    var body: some View {
        List {
            ForEach(Array(numbers.enumerated()), id: \.offset) { idx, num in
                Text("\(num)")
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive, action: { remove(at: idx) } ) {
                            Text("Delete")
                        }
                    }
            }
        }
    }
    
    private func remove(at index: Int) {
        numbers.remove(at: index)
    }
}
