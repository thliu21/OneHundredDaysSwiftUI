//
//  HabitRenameView.swift
//  Habit
//
//  Created by Tianhao Liu on 11/30/22.
//

import SwiftUI
import RealmSwift

struct HabitRenameView: View {
    @ObservedRealmObject var habit: Habit
    @State private var newName: String = ""
    
    @Binding var isShowing: Bool
    
    var body: some View {
        Form {
            Section {
                TextField("New Name", text: $newName)
            } header: {
                Text("New name")
            }
            Section {
                Button {
                    $habit.title.wrappedValue = newName
                    isShowing = false
                } label: {
                    Text("Done")
                }
            }
        }
        .navigationTitle("Rename")
        .onAppear {
            newName = habit.title
        }
    }
}
