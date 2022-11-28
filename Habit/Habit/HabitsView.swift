//
//  HabitsView.swift
//  Habit
//
//  Created by Tianhao Liu on 11/27/22.
//

import SwiftUI
import RealmSwift

struct HabitsView: View {
    @ObservedRealmObject var habitCollection: HabitCollection
    
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(habitCollection.habits, id: \._id) { habit in
                        Text(habit.name)
                    }
                }
                Section {
                    VStack {
                        NavigationLink(
                            destination: NewHabitView(
                                habitCollection: habitCollection,
                                action: $action
                            ),
                            tag: 1,
                            selection: $action) {
                                Button {
                                    action = 1
                                } label: {
                                    Text("Add new")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Habits")
        }
    }
}
