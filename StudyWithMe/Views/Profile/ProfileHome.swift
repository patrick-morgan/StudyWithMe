//
//  ProfileHome.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 10/26/21.
//

import SwiftUI
import RealmSwift

struct ProfileHome: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(User.self) var users
    
    var body: some View {
        print(users)
        
        return VStack {
            Text("\(state.user!.userPreferences!.userName)'s Profile Page")
//            if let checkIns =
            
        }
    }
}

struct ProfileHome_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHome()
    }
}
