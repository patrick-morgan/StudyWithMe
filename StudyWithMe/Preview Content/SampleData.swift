//
//  SampleData.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import Foundation
import RealmSwift
import UIKit

protocol Samplable {
    associatedtype Item
    static var sample: Item { get }
    static var samples: [Item] { get }
}

extension Date {
    static var random: Date {
        Date(timeIntervalSince1970: (50 * 365 * 24 * 3600 + Double.random(in: 0..<(3600 * 24 * 365))))
    }
}

extension User {
    convenience init(email: String, firstName: String, lastName: String, userPreferences: UserPreferences) {
        self.init()
        partition = "user=\(_id)"
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.userPreferences = userPreferences
//        self.lastSeenAt = Date.random
//        checkIns.forEach { checkIn in
//            self.checkIns.append(checkIn)
//        }
    }
    
    convenience init(_ user: User) {
        self.init()
        partition = user.partition
        email = user.email
        firstName = user.firstName
        lastName = user.lastName
        userPreferences = UserPreferences(user.userPreferences)
//        lastSeenAt = user.lastSeenAt
//        checkIns.append(objectsIn: user.checkIns.map { CheckIn($0) })
    }
}

extension User: Samplable {
    static var samples: [User] { [sample, sample2, sample3] }
    static var sample: User {
        User(email: "rod@rod.com", firstName: "Rod", lastName: "Smith", userPreferences: .sample)
    }
    static var sample2: User {
        User(email: "bob@bob.com", firstName: "Bob", lastName: "Blame", userPreferences: .sample2)    }
    static var sample3: User {
        User(email: "mary@mary.com", firstName: "Mary", lastName: "Laflam", userPreferences: .sample3)    }
//    static var sample: User {
//        User(email: "rod@rod.com", firstName: "Rod", lastName: "Smith", userPreferences: .sample, checkIns: [.sample, .sample2])
//    }
//    static var sample2: User {
//        User(email: "bob@bob.com", firstName: "Bob", lastName: "Blame", userPreferences: .sample2, checkIns: [.sample2, .sample3])    }
//    static var sample3: User {
//        User(email: "mary@mary.com", firstName: "Mary", lastName: "Laflam", userPreferences: .sample3, checkIns: [.sample, .sample2, .sample3])    }
}

extension UserPreferences {
    convenience init(userName: String, profilePhoto: Photo) {
        self.init()
        self.userName = userName
        self.profilePhoto = profilePhoto
    }
    
    convenience init(_ userPreferences: UserPreferences?) {
        self.init()
        if let userPreferences = userPreferences {
            userName = userPreferences.userName
            profilePhoto = Photo(userPreferences.profilePhoto)
        }
    }
}

extension UserPreferences: Samplable {
    static var samples: [UserPreferences] { [sample, sample2, sample3] }
    static var sample = UserPreferences(userName: "Rod Smith", profilePhoto: .sample)
    static var sample2 = UserPreferences(userName: "Bob Blame", profilePhoto: .sample2)
    static var sample3 = UserPreferences(userName: "Mary Laflam", profilePhoto: .sample3)
}

extension CheckIn {
    convenience init(locationId: String, time: Date) {
        self.init()
        self.locationId = locationId
        self.time = time
    }
    
    convenience init(_ checkIn: CheckIn) {
        self.init()
        locationId = checkIn.locationId
        time = checkIn.time
    }
}

extension CheckIn: Samplable {
    static var samples: [CheckIn] { [sample, sample2, sample3] }
    static var sample: CheckIn {
        CheckIn(locationId: "starbucks", time: Date.random)
    }
    static var sample2: CheckIn {
        CheckIn(locationId: "shinola", time: Date.random)
    }
    static var sample3: CheckIn {
        CheckIn(locationId: "union", time: Date.random)
    }
}

extension PublicUser {
    convenience init(user: User) {
        self.init()
        self._id = user._id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.userName = user.userPreferences!.userName
        self.profilePhoto = Photo(user.userPreferences?.profilePhoto)
        lastSeenAt = Date.random
//        self.checkIns.append(objectsIn: user.checkIns.map { CheckIn($0) })
    }
    
    convenience init(_ publicUser: PublicUser) {
        self.init()
        partition = publicUser.partition
        firstName = publicUser.firstName
        lastName = publicUser.lastName
        userName = publicUser.userName
        profilePhoto = Photo(publicUser.profilePhoto)
        lastSeenAt = publicUser.lastSeenAt
//        checkIns.append(objectsIn: publicUser.checkIns.map { CheckIn($0) })
    }
}

extension PublicUser: Samplable {
    static var samples: [PublicUser] { [sample, sample2, sample3] }
    static var sample: PublicUser { PublicUser(user: User(.sample)) }
    static var sample2: PublicUser { PublicUser(user: User(.sample2)) }
    static var sample3: PublicUser { PublicUser(user: User(.sample3)) }
}

extension AppState {
    convenience init(user: User) {
        self.init()
        self.user = user
    }
}

extension AppState: Samplable {
    static var samples: [AppState] { [sample, sample2, sample3] }
    static var sample: AppState { AppState(user: .sample) }
    static var sample2: AppState { AppState(user: .sample2) }
    static var sample3: AppState { AppState(user: .sample3) }
}

extension Photo {
    convenience init(photoName: String) {
        self.init()
        self.thumbNail = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.picture = (UIImage(named: photoName) ?? UIImage()).jpegData(compressionQuality: 0.8)
        self.date = Date.random
    }
    convenience init(_ photo: Photo?) {
        self.init()
        if let photo = photo {
            self.thumbNail = photo.thumbNail
            self.picture = photo.picture
            self.date = photo.date
        }
    }
}

extension Photo: Samplable {
    static var samples: [Photo] { [sample, sample2, sample3, starbucksPhoto, shinolaPhoto, unionPhoto]}
    static var sample: Photo { Photo(photoName: "rod") }
    static var sample2: Photo { Photo(photoName: "bob") }
    static var sample3: Photo { Photo(photoName: "nom") }
    static var starbucksPhoto: Photo { Photo(photoName: "starbucks") }
    static var shinolaPhoto: Photo { Photo(photoName: "shinola") }
    static var unionPhoto: Photo { Photo(photoName: "union") }
}

extension Location {
    convenience init(name: String, address: String, city: String, state: String) {
        self.init()
        self.name = name
        self.address = address
        self.city = city
        self.state = state
//        self.imageName = imageName
//        self.coordinates = coordinates
    }
    
    convenience init(_ location: Location) {
        self.init()
        partition = location.partition
        name = location.name
        address = location.address
        city = location.city
        state = location.state
//        imageName = location.imageName
//        coordinates = location.coordinates
    }
}

extension Location: Samplable {
    static var samples: [Location] { [sample, sample2, sample3] }
    static var sample: Location { Location(name: "Starbucks S University", address: "1214 S University Ave", city: "Ann Arbor", state: "Michigan") }
    static var sample2: Location { Location(name: "Shinola Store", address: "301 S Main St", city: "Ann Arbor", state: "Michigan") }
    static var sample3: Location { Location(name: "Michigan Union", address: "530 S State St", city: "Ann Arbor", state: "Michigan") }
//    static var sample: Location { Location(name: "Starbucks S University", address: "1214 S University Ave", city: "Ann Arbor", state: "Michigan") }
//    static var sample2: Location { Location(name: "Shinola Store", address: "301 S Main St", city: "Ann Arbor", state: "Michigan") }
//    static var sample3: Location { Location(name: "Michigan Union", address: "530 S State St", city: "Ann Arbor", state: "Michigan") }
//    static var sample: Location { Location(name: "Starbucks S University", address: "1214 S University Ave", city: "Ann Arbor", state: "Michigan", imageName: "starbucks", coordinates: .sample) }
//    static var sample2: Location { Location(name: "Shinola Store", address: "301 S Main St", city: "Ann Arbor", state: "Michigan", imageName: "shinola", coordinates: .sample2) }
//    static var sample3: Location { Location(name: "Michigan Union", address: "530 S State St", city: "Ann Arbor", state: "Michigan", imageName: "union", coordinates: .sample3) }
}

extension LocationHours {
    convenience init(sunday: String, monday: String, tuesday: String, wednesday: String, thursday: String, friday: String, saturday: String) {
        self.init()
        self.sunday = sunday
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
    }
    
    convenience init(_ locationHours: LocationHours) {
        self.init()
        sunday = locationHours.sunday
        monday = locationHours.monday
        tuesday = locationHours.tuesday
        wednesday = locationHours.wednesday
        thursday = locationHours.thursday
        friday = locationHours.friday
        saturday = locationHours.saturday
    }
}

extension LocationHours: Samplable {
    static var samples: [LocationHours] { [sample, sample2, sample3] }
    static var sample: LocationHours { LocationHours(sunday: "6AM-9PM", monday: "5:30AM-10PM", tuesday: "5:30AM-10PM", wednesday: "5:30AM-10PM", thursday: "5:30AM-10PM", friday: "5:30AM-10PM", saturday: "6AM-9PM")}
    static var sample2: LocationHours { LocationHours(sunday: "11AM-7PM", monday: "11AM-7PM", tuesday: "11AM-7PM", wednesday: "11AM-7PM", thursday: "11AM-7PM", friday: "11AM-7PM", saturday: "11AM-7PM")}
    static var sample3: LocationHours { LocationHours(sunday: "9AM-2AM", monday: "7AM-2AM", tuesday: "7AM-2AM", wednesday: "7AM-2AM", thursday: "7AM-2AM", friday: "7AM-2AM", saturday: "7AM-2AM")}
}

extension Coordinates {
    convenience init(latitude: Double, longitude: Double) {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init(_ coordinates: Coordinates) {
        self.init()
        latitude = coordinates.latitude
        longitude = coordinates.longitude
    }
}

extension Coordinates: Samplable {
    static var samples: [Coordinates] { [sample, sample2, sample3] }
    static var sample: Coordinates { Coordinates(latitude: 42.27506374973899, longitude: -83.73405691720389) }
    static var sample2: Coordinates { Coordinates(latitude: 42.279595200351196, longitude: -83.74835475953326) }
    static var sample3: Coordinates { Coordinates(latitude: 42.27520001087085, longitude: -83.74108554475941) }
}
// extension Coordinates {
//    convenience init(latitude: Double, longitude: Double) {
//        self.init()
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//
//    convenience init(_ coordinate: Coordinates) {
//        self.init()
//        latitude = coordinate.latitude
//        longitude = coordinate.longitude
//    }
// }

// extension Coordinates: Samplable {
////    static var samples: [Coordinates] { [ sample, sample2, sample3 ]}
//    static var samples: [Coordinates] { [ sample ]}
//
//    static var sample: Coordinates { Coordinates(latitude: 42.27506374973899, longitude: -83.73405691720389) }
//    static var sample2: Coordinates { Coordinates(latitude: 42.279595200351196, longitude: -83.74835475953326) }
//    static var sample3: Coordinates { Coordinates(latitude: 42.27520001087085, longitude: -83.74108554475941) }
// }

extension Realm: Samplable {
    static var samples: [Realm] { [sample] }
    static var sample: Realm {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
            User.samples.forEach { user in
                realm.add(user)
            }
            PublicUser.samples.forEach { publicUser in
                realm.add(publicUser)
            }
            Location.samples.forEach { location in
                realm.add(location)
            }
        }
        return realm
    }
    
    static func bootstrap() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
                realm.add(PublicUser.samples)
                realm.add(User(User.sample))
                realm.add(Location.samples)
            }
        } catch {
            print("Failed to bootstrap the default realm")
        }
    }
}
