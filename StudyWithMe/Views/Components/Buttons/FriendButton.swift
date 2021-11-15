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
    
    var done: () -> Void = { }

    var body: some View {
        if friend != nil {
            if friend!.relationship == .friend {
                if tapped {
                    Button("Fish") {}
                        .disabled(true)
//                    Button("Remove Friend") {}
//                        .disabled(true)
                } else {
                    Button(action: removeFriendship) {
                        Text("Remove Friend")
                    }
                }
            }
            // Check if Pending
            else if friend!.relationship == .incomingPending {
                if tapped {
                    Button("Fish Here") {}
                        .disabled(true)
//                    Button("Remove Friend") {}
//                        .disabled(true)
                } else {
                    Button(action: addFriendBack) {
                        Text("Add Friend Back")
                    }
                }
            } else if friend!.relationship == .outgoingPending {
                if tapped {
                    Button("Add Friend") {}
                        .disabled(true)
                } else {
                    Button(action: removeFriendship) {
                        Text("Request Pending")
                    }
                }
            }
        } else {
            // Add Friend
            if tapped {
                Button("Pending Fish") {}
                    .disabled(true)
//                    Button("Remove Friend") {}
//                        .disabled(true)
            } else {
                Button(action: addFriend) {
                    Text("Add Friend")
                }
            }
        }
//        if tapped {
//            Button("Checked In") {}
//                .disabled(true)
//        } else {
//            Button(action: addFriend) {
//                Text("Check In")
//            }
//        }
    }
    
    private func addFriendBack() {
        state.shouldIndicateActivity = true
        do {
            try userRealm.write {
                friend!.relationship = .friend
            }
        } catch {
            state.error = "Unable to add friend with friendId \(friend!.friendId) back"
            state.shouldIndicateActivity = false
            print("Unable to add friend with friendId \(friend!.friendId) back")
            return
        }
        state.shouldIndicateActivity = false
    }
    
    private func removeFriendship() {
        state.shouldIndicateActivity = true
        
        guard let user = userRealm.object(ofType: User.self, forPrimaryKey: state.user!._id) else {
            print("unable to get user")
            state.shouldIndicateActivity = false
            return
        }
        do {
            try userRealm.write {
                let friendshipP = user.friends.filter("friendId = %@", friendId).first
    //            print("frinshiPP")
    //            print(friendshipP)
                
                if friendshipP != nil {
                    userRealm.delete(friendshipP!)
                }
            }
        } catch {
            state.error = "Unable to delete friendship with friendId \(friend!.friendId)"
            state.shouldIndicateActivity = false
            print("Unable to add delete friendship with friendId \(friend!.friendId)")
            return
        }

        state.shouldIndicateActivity = false
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
        state.shouldIndicateActivity = false
    }
}

struct FriendButton_Previews: PreviewProvider {
    static var previews: some View {
        FriendButton(friendId: "")
    }
}
