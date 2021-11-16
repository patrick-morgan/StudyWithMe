//
//  FriendButton.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 11/15/21.
//

import SwiftUI
import RealmSwift

struct FriendButton: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @ObservedResults(User.self) var users
    
    var friendId: String
    
    var friend: Friend? {
        users[0].friends.filter("friendId = %@", friendId).first
    }
    
    @State var tapped: Bool = false
    
    var body: some View {
        if friend != nil {
            // Remove friend
            if friend!.relationship == .friend {
                Button(action: removeFriendship) {
                    Text("Remove Friend")
                }
            }
            // Check if Pending
            else if friend!.relationship == .incomingPending {
                Button(action: addFriendBack) {
                    Text("Add Friend Back")
                }
            } else if friend!.relationship == .outgoingPending {
                Button(action: removeFriendship) {
                    Text("Request Pending")
                }
            }
        } else {
            // Add Friend
            Button(action: addFriend) {
                Text("Add Friend")
            }
        }
    }
    
    private func addFriendBack() {
        // Called for accepting incoming friendship requests
        state.shouldIndicateActivity = true
        do {
            let thawedFriend = friend!.thaw()
            try userRealm.write {
                thawedFriend!.relationship = .friend
            }
        } catch {
            state.error = "Unable to add friend with friendId \(friend!.friendId) back"
            state.shouldIndicateActivity = false
            print("Unable to add friend with friendId \(friend!.friendId) back")
            return
        }
        do {
            let user = app.currentUser!
            // This function will update the friends array for the user w/ id equal to the first argument
            // it will change the relationship with friendId equal to the second argument
            // it will change the relationshipType to the third argument
            user.functions.updateOtherUserFriendship([AnyBSON(friendId), AnyBSON(state.user!._id), AnyBSON("friend")]) { _, error in
                guard error == nil else {
                    print("Function call failed: \(error!.localizedDescription)")
                    state.shouldIndicateActivity = false
                    return
                }
                print("Updated user friendship for \(friendId)")
            }
        }
        state.shouldIndicateActivity = false
    }
    
    private func removeFriendship() {
        state.shouldIndicateActivity = true
        
        // Remove friendship from both users friends
        guard let user = userRealm.object(ofType: User.self, forPrimaryKey: state.user!._id) else {
            print("unable to get user")
            state.shouldIndicateActivity = false
            return
        }
        do {
            try userRealm.write {
                let friendship = user.friends.filter("friendId = %@", friendId).first
                
                if friendship != nil {
                    userRealm.delete(friendship!)
                }
            }
        } catch {
            state.error = "Unable to delete friendship with friendId \(friend!.friendId)"
            state.shouldIndicateActivity = false
            print("Unable to add delete friendship with friendId \(friend!.friendId)")
            return
        }
        do {
            let user = app.currentUser!
            // This function will delete the relationship from the friends array for the user w/ id equal to the first argument
            // and friendId equal to the second argumesnt
            user.functions.removeFriend([AnyBSON(friendId), AnyBSON(state.user!._id)]) { _, error in
                guard error == nil else {
                    print("Function call failed: \(error!.localizedDescription)")
                    state.shouldIndicateActivity = false
                    return
                }
                print("Deleted user friendship for \(friendId)")
            }
        }

        state.shouldIndicateActivity = false
        
        // TODO: Figure out why this doesn't work, and why the above works instead
//        print(users[0])
//        print(friend)
//        do {
//            try userRealm.write {
//                userRealm.delete(friend!)
//            }
//        } catch {
//            state.error = "Unable to delete friendship with friendId \(friend!.friendId)"
//            print("Unable to add delete friendship with friendId \(friend!.friendId)")
//            return
//        }
    }
    
    private func addFriend() {
        state.shouldIndicateActivity = true
        let friendship = Friend()
        friendship.friendId = friendId
        friendship.relationship = .outgoingPending
        do {
            try userRealm.write {
                state.user?.friends.append(friendship)
            }
        } catch {
            state.error = "Unable to add friend with friendId \(friendId)"
            state.shouldIndicateActivity = false
            print("Unable to add friend with friendId \(friendId)")
            return
        }
        do {
            let user = app.currentUser!
            // This function will add a new relationship to the friends array for the user w/ id equal to the first argument
            // it will set friendId equal to the second argumesnt, and relationshipType to "incomingPending"
            user.functions.addFriend([AnyBSON(friendId), AnyBSON(state.user!._id), AnyBSON("incomingPending")]) { _, error in
                guard error == nil else {
                    print("Function call failed: \(error!.localizedDescription)")
                    state.shouldIndicateActivity = false
                    return
                }
                print("Added new user friendship for \(friendId)")
            }
        }
        state.shouldIndicateActivity = false
    }
}

struct FriendButton_Previews: PreviewProvider {
    static var previews: some View {
        FriendButton(friendId: "")
    }
}
