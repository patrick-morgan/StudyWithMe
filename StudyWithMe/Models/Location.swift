//
//  Location.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift
import CoreLocation

final class Location: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var partition = "location=all-the-users" // "location=all-the-users" --> all users can access
    @Persisted var name = ""
    @Persisted var address = ""
    @Persisted var city = ""
    @Persisted var state = ""
    @Persisted var photo: Photo?
//    @Persisted var locationHours: LocationHours?
    
    // Coordinate for map view
//    @Persisted var coordinates: Coordinates
//    var locationCoordinates: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude
//        )
//    }
}
