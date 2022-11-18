//
//  MissionView.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/17/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.compactMap { member in
            guard let astronaut = astronauts[member.name]
            else {
                fatalError("Missing \(member.name)")
            }
            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
    
    var body: some View {
        ZStack {
            Color.darkBackground.edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Image(asset: mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.6)
                        
                        VStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.lightBackground)
                                .padding(.vertical)

                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)

                            Text(mission.description)

                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(.lightBackground)
                                .padding(.vertical)

                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack() {
                                ForEach(crew, id: \.role) { crew in
                                    NavigationLink {
                                        AstronautView(astronaut: crew.astronaut)
                                    } label: {
                                        HStack {
                                            Image(asset: crew.astronaut.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 104)
                                                .clipShape(Capsule())
                                                .overlay(
                                                    Capsule()
                                                        .strokeBorder(.white, lineWidth: 1)
                                                )
                                            
                                            VStack(alignment: .leading) {
                                                Text(crew.astronaut.name)
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                Text(crew.role)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.darkBackground)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decodeJsonFile(JsonFiles.missionsJson)
    static let astronauts: [String: Astronaut] = Bundle.main.decodeJsonFile(JsonFiles.astronautsJson)
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
