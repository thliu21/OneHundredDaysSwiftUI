//
//  NewHabitView.swift
//  Habit
//
//  Created by Tianhao Liu on 11/27/22.
//

import SwiftUI
import RealmSwift

struct NewHabitView: View {
    @ObservedRealmObject var habitCollection: HabitCollection
    
    @Binding var action: Int?
    
    @State private var name = ""
    @State private var habitType: Habit.HabitType = .wellness
    
    var body: some View {
        Form {
            Section {
                TextField("Habit name", text: $name)
                Picker("Type", selection: $habitType) {
                    ForEach(Habit.HabitType.allCases) { habitType in
                        Text(habitType.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            Section {
                Button {
                    let habit = Habit()
                    habit.name = name
                    habit.habitType = habitType
                    $habitCollection.habits.append(habit)
                    action = nil
                } label: {
                    Text("Add")
                        .foregroundColor(.blue)
                }
            }
            Section {
                Button {
                    action = nil
                } label: {
                    Text("Cancel")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("New habit")
        .navigationBarTitleDisplayMode(.inline)
    }
}
