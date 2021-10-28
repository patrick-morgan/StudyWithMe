//
//  Location.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift
import CoreLocation
import SwiftUI

final class Location: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id = UUID().uuidString
    @Persisted var partition = "location=all-the-users" // "location=all-the-users" --> all users can access
    @Persisted var name = ""
    @Persisted var address = ""
    @Persisted var city = ""
    @Persisted var state = ""
    @Persisted var imageName: String
    var image: Image {
        Image(imageName)
    }
//    @Persisted var locationHours: LocationHours?
    
    // Coordinate for map view
    // To-one relationships in realm must always be marked optional
    @Persisted var coordinates: Coordinates?
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates!.latitude,
            longitude: coordinates!.longitude
        )
    }
}
