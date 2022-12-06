//
//  ContentView.swift
//  Tryout
//
//  Created by Tianhao Liu on 10/28/22.
//

import SwiftUI

class TestObject: ObservableObject {
    @Published var input: String = ""
    
}

struct ContentView: View {
    @StateObject var data = TestObject()
    
    var body: some View {
        VStack {
            TextField("Input", text: $data.input, prompt: nil)
            
            Text(data.input)
        }
    }
}
