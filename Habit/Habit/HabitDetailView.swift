//
//  HabitDetailView.swift
//  Habit
//
//  Created by Tianhao Liu on 11/29/22.
//

import SwiftUI
import RealmSwift

struct HabitDetailView: View {
    @ObservedRealmObject var habit: Habit
    @State private var presentRename: Bool = false
    
    var body: some View {
        List {
            Section {
                Button {
                    $habit.records.append(Record())
                } label: {
                    Text("New record")
                }
                
            }
            Section {
                ForEach(Array(zip(habit.records.reversed(), habit.records.indices)), id: \.0) { record, idx in
                    HStack {
                        Text("#\(habit.records.count - idx)")
                        Spacer()
                        Text(Self.formatter.string(for: record.creationTime) ?? "Error")
                            .foregroundColor(Color.gray)
                    }
                }
                .onDelete(perform: deleteItems)
            } footer: {
                Text("Started on \(habit.creationTime)")
                    .padding(.top)
            }
        }
        .navigationTitle(habit.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Rename") {
                presentRename.toggle()
            }
            .sheet(isPresented: $presentRename) {
                HabitRenameView(habit: habit, isShowing: $presentRename)
            }
        }
    }
    
    private func deleteItems(at offsets: IndexSet) {
        let reversedSet = IndexSet(offsets.map({ offset in
            habit.records.count - offset - 1
        }))
        $habit.records.remove(atOffsets: reversedSet)
    }
    
    static private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
