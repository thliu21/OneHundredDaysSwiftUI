//
//  ContentView.swift
//  Habit
//
//  Created by Tianhao Liu on 11/24/22.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var searchFilter: String = ""
    @ObservedResults(HabitCollection.self) var habitCollection
    
    var body: some View {
        if let collection = habitCollection.first {
            HabitsView(habitCollection: collection)
        } else {
            ProgressView().onAppear {
                $habitCollection.append(HabitCollection())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
