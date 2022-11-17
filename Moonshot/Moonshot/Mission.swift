//
//  Mission.swift
//  Moonshot
//
//  Created by Tianhao Liu on 11/10/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    enum missionId: Int, Codable {
        case apollo1 = 1
        case apollo7 = 7
        case apollo8 = 8
        case apollo9 = 9
        case apollo10 = 10
        case apollo11 = 11
        case apollo12 = 12
        case apollo13 = 13
        case apollo14 = 14
        case apollo15 = 15
        case apollo16 = 16
        case apollo17 = 17
    }
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: missionId
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id.rawValue)"
    }
    
    var image: ImageAsset {
        switch self.id {
        case .apollo1:
            return ImageAssets.apollo1
        case .apollo7:
            return ImageAssets.apollo7
        case .apollo8:
            return ImageAssets.apollo8
        case .apollo9:
            return ImageAssets.apollo9
        case .apollo10:
            return ImageAssets.apollo10
        case .apollo11:
            return ImageAssets.apollo11
        case .apollo12:
            return ImageAssets.apollo12
        case .apollo13:
            return ImageAssets.apollo13
        case .apollo14:
            return ImageAssets.apollo14
        case .apollo15:
            return ImageAssets.apollo15
        case .apollo16:
            return ImageAssets.apollo16
        case .apollo17:
            return ImageAssets.apollo17
        }
    }
    
    var formattedLaunchDate: String {
        guard let date = launchDate else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMddyyyy", options: 0, locale: Locale.current)
        return formatter.string(from: date)
    }
}
