//
//  Coordinates.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import Foundation
import RealmSwift

class Coordinates: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var latitude: Double
    @Persisted var longitude: Double
}
