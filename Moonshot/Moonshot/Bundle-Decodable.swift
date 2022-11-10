//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/10/22.
//

import Foundation

extension Bundle {
    func decodeAstronauts() -> [String: Astronaut] {
        let fileURL = JsonFiles.astronautsJson.url
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load astronauts.json from bundle.")
        }
        guard let loaded = try? JSONDecoder().decode([String: Astronaut].self, from: data) else {
            fatalError("Failed to decode astronauts.json")
        }
        return loaded
    }
}
