//
//  ContentView.swift
//  Tryout
//
//  Created by Tianhao Liu on 10/28/22.
//

import SwiftUI

class TestObject: ObservableObject {
    var value: Int = 0 {
        didSet {
            objectWillChange.send()
        }
    }
}

struct ContentView: View {
    @StateObject var data = TestObject()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("value is \(data.value)")
                
                NavigationLink {
                    DetailView(data: data)
                } label: {
                    Text("Update")
                }
            }
        }
    }
}

struct DetailView: View {
    @ObservedObject var data: TestObject
    
    var body: some View {
        VStack {
            Text("current \(data.value)")
            
            Button {
                data.value += 1
            } label: {
                Text("Plus!")
            }
        }
    }
}
