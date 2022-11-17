//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/10/22.
//

import Foundation

extension Bundle {
    func decodeJsonFile<T: Codable>(_ file: File) -> T {
        let fileURL = file.url
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("Failed to load \(file.name) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file.name)")
        }
        return loaded
    }
}
