//
//  Photo.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/11/21.
//

import Foundation
import RealmSwift

class Photo: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var _id = UUID().uuidString
    @Persisted var thumbNail: Data?
    @Persisted var picture: Data?
    @Persisted var date = Date()
}
