//
//  Utilities.swift
//  BetterRest
//
//  Created by Tianhao Liu on 10/29/22.
//

import Foundation

extension Double {
    var simplifiedString: String {
        var formattedValue = String(format: "%.2f", self)

        while formattedValue.last == "0" {
            formattedValue.removeLast()
        }

        if formattedValue.last == "." {
            formattedValue.removeLast()
        }

        return formattedValue
    }
}

extension Date {
    func formatedHoursAndMinutes() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(for: self)
    }
}
