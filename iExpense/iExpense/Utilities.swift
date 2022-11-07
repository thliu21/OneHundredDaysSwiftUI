//
//  Utilities.swift
//  iExpense
//
//  Created by Tianhao Liu on 11/6/22.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
   func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
} }
#endif
