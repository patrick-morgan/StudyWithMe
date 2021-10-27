//
//  LocationRow.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/27/21.
//

import SwiftUI
import RealmSwift

struct LocationRow: View {
    var location: Location
    
    var body: some View {
        HStack {
            Text(location.name)
        }
    }
}

struct LocationRow_Previews: PreviewProvider {
    static var previews: some View {
        Realm.bootstrap()

        return LocationRow(location: .sample)
    }
}
