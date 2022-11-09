//
//  ContentView.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/9/22.
//

import SwiftUI

struct ContentView: View {
    private let layout = [
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 200))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(1..<1001) {
                    Text("Num: \($0)")
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
