//
//  Location.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

final class Location: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var partition = "" // "location=_id"
    @Persisted var name = ""
    @Persisted var address = ""
    @Persisted var city = ""
    @Persisted var state = ""
    @Persisted var locationPhoto: Photo?
    @Persisted var locationHours: LocationHours?
    
    // Coordinate for map view
//    @Persisted var locationCoordinate:
}
