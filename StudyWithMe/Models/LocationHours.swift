//
//  LocationHours.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

final class LocationHours: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var _id = UUID().uuidString
    @Persisted var sunday = ""
    @Persisted var monday = ""
    @Persisted var tuesday = ""
    @Persisted var wednesday = ""
    @Persisted var thursday = ""
    @Persisted var friday = ""
    @Persisted var saturday = ""
}
