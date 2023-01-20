//
//  EditView.swift
//  BucketList
//
//  Created by Arthur Liu on 1/19/23.
//

import SwiftUI

struct EditView: View {
    typealias onSaveCallback = (Location) -> Void
    
    @Environment(\.dismiss) var dismiss
    private var location: Location
    private let onSave: onSaveCallback
    @State private var name: String
    @State private var desc: String

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Description", text: $desc)
            }
            Section {
                Button("Save") {
                    var new = location
                    new.id = UUID()
                    new.name = name
                    new.description = desc
                    onSave(new)
                    dismiss()
                }
                .foregroundColor(.blue)
                Button("Dismiss") {
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
    }
    
    init(location: Location, onSave: @escaping onSaveCallback) {
        self.location = location
        self.onSave = onSave
        _name = State(initialValue: location.name)
        _desc = State(initialValue: location.description)
    }
}
