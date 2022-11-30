//
//  Model.swift
//  Habit
//
//  Created by Tianhao Liu on 11/27/22.
//

import Foundation
import RealmSwift

class Record: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var creationTime: Date = Date()
}

class Habit: Object, ObjectKeyIdentifiable {
    enum HabitType: String, PersistableEnum, CaseIterable, Identifiable {
        case wellness = "Wellness"
        case career = "Career"
        case other = "Other"
        
        var id: Self { self }
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = ""
    @Persisted var creationTime: Date = Date()
    @Persisted var records = List<Record>()
    @Persisted var habitType: HabitType
}

class HabitCollection: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var habits = List<Habit>()
}
