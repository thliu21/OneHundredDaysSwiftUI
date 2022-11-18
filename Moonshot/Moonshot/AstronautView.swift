//
//  AstronautView.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/17/22.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ZStack {
            Color.darkBackground.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Image(asset: astronaut.image)
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading, spacing: 0) {
                        Text(astronaut.name)
                            .font(.title)
                            .padding(.vertical)
                        Text(astronaut.description)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decodeJsonFile(JsonFiles.astronautsJson)
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
