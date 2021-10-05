//
//  ContentView.swift
//  StudyWithMe
//
//  Created by Patrick Morgan on 9/21/21.
//

import RealmSwift
import SwiftUI
let lightGreyColor = Color(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, opacity: 1.0)

struct ContentView: View {
    @StateObject private var userRealmConfiguration = UserRealmConfiguration()
//    self.userRealmConfiguration.signedIn = true
//    print("true!")
    
    var body: some View {
        if !userRealmConfiguration.signedIn {
            SignInView()
                .environmentObject(userRealmConfiguration)
        } else {
            HomeView()
                .environmentObject(userRealmConfiguration)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

///// Random adjectives for more interesting demo item names
// let randomAdjectives = [
//    "fluffy", "classy", "bumpy", "bizarre", "wiggly", "quick", "sudden",
//    "acoustic", "smiling", "dispensable", "foreign", "shaky", "purple", "keen",
//    "aberrant", "disastrous", "vague", "squealing", "ad hoc", "sweet"
// ]
///// Random noun for more interesting demo item names
// let randomNouns = [
//    "floor", "monitor", "hair tie", "puddle", "hair brush", "bread",
//    "cinder block", "glass", "ring", "twister", "coasters", "fridge",
//    "toe ring", "bracelet", "cabinet", "nail file", "plate", "lace",
//    "cork", "mouse pad"
// ]
//
///// An individual item. Part of a `Group`.
// final class Item: Object, ObjectKeyIdentifiable {
//    /// The unique ID of the Item. `primaryKey: true` declares the
//    /// _id member as the primary key to the realm.
//    @Persisted(primaryKey: true) var _id: ObjectId
//    /// The name of the Item, By default, a random name is generated.
//    @Persisted var name = "\(randomAdjectives.randomElement()!) \(randomNouns.randomElement()!)"
//    /// A flag indicating whether the user "favorited" the item.
//    @Persisted var isFavorite = false
//    /// The backlink to the `Group` this item is a part of.
//    @Persisted(originProperty: "items") var group: LinkingObjects<Group>
// }
//
///// Represents a collection of items.
// final class Group: Object, ObjectKeyIdentifiable {
//    /// The unique ID of the Group. `primaryKey: true` declares the
//    /// _id member as the primary key to the realm.
//    @Persisted(primaryKey: true) var _id: ObjectId
//    /// The collection of Items in this group.
//    @Persisted var items = RealmSwift.List<Item>()
// }
//
///// The main content view if not using Sync.
// struct LocalOnlyContentView: View {
//    // Implicitly use the default realm's objects(Group.self)
//    @ObservedResults(Group.self) var groups
//
//    var body: some View {
//        if let group = groups.first {
//            AnyView(ItemsView(group: group))
//        } else {
//            // For this small app, we only want one group in the realm.
//            // You can expand this app to support multiple groups.
//            // For now, if there is no group, add one here.
//            AnyView(ProgressView().onAppear {
//                $groups.append(Group())
//            })
//        }
//    }
// }
//
///// The screen containing a list of items in a group. Implements functionality for adding, rearranging,
///// and deleting items in the group.
// struct ItemsView: View {
//    /// The group is a container for a list of items. Using a group instead of all items
//    /// directly allows us to maintain a list order that can be updated in the UI.
//    @ObservedRealmObject var group: Group
//    /// The button to be displayed on the top left.
//    var leadingBarButton: AnyView?
//    var body: some View {
//        NavigationView {
//            VStack {
//                // The list shows the items in the realm.
//                List {
//                    ForEach(group.items) { item in
//                        ItemRow(item: item)
//                    }.onDelete(perform: $group.items.remove)
//                    .onMove(perform: $group.items.move)
//                }.listStyle(GroupedListStyle())
//                    .navigationBarTitle("Items", displayMode: .large)
//                    .navigationBarBackButtonHidden(true)
//                    .navigationBarItems(
//                        leading: self.leadingBarButton,
//                        // Edit button on the right to enable rearranging items
//                        trailing: EditButton())
//                // Action bar at bottom contains Add button.
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // The bound collection automatically
//                        // handles write transactions, so we can
//                        // append directly to it.
//                        $group.items.append(Item())
//                    }) { Image(systemName: "plus") }
//                }.padding()
//            }
//        }
//    }
// }
//
///// Represents an Item in a list.
// struct ItemRow: View {
//    @ObservedRealmObject var item: Item
//    var body: some View {
//        // You can click an item in the list to navigate to an edit details screen.
//        NavigationLink(destination: ItemDetailsView(item: item)) {
//            Text(item.name)
//            if item.isFavorite {
//                // If the user "favorited" the item, display a heart icon
//                Image(systemName: "heart.fill")
//            }
//        }
//    }
// }
///// Represents a screen where you can edit the item's name.
// struct ItemDetailsView: View {
//    @ObservedRealmObject var item: Item
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Enter a new name:")
//            // Accept a new name
//            TextField("New name", text: $item.name)
//                .navigationBarTitle(item.name)
//                .navigationBarItems(trailing: Toggle(isOn: $item.isFavorite) {
//                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
//                })
//        }.padding()
//    }
// }
