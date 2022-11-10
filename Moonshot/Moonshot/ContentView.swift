//
//  ContentView.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/9/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decodeAstronauts()
    
    var body: some View {
        Text("\(astronauts.count)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
