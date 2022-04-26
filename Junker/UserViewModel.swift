//
//  UserViewModel.swift
//  Junker
//
//  Created by Xander on 4/19/22.
//

import Firebase

class UserViewModel: ObservableObject {

    @Published var errorMessage = ""
    @Published var currentUser: User?

    init() {
        fetchCurrentUser()
    }

    private func fetchCurrentUser() {

        guard let uid = Auth.auth().currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }

            guard let data = snapshot?.data() else {
                self.errorMessage = "No data found"
                return

            }
//            let email = data["email"] as? String ?? ""
//            let displayName = data["displayName"] as? String ?? ""
//            let profilePicture = data["profilePicture"] as? String ?? ""
//            let currentCommunity = data["currentCommunity"] as? String ?? ""
//            let prayerRequests = data["prayerRequests"] as? [String] ?? []
//            let communities = data["communities"] as? [String] ?? []
//            let streak = data["streak"] as? Int ?? -1
//            let pick = data["pick"] as? Int ?? -1
            
            
            self.currentUser = User(data: data)
            
//            let pushManager = PushNotificationManager(userID: uid)
//                    pushManager.registerForPushNotifications()
            
            
            }
//        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
//            if let error = error {
//                self.errorMessage = "Failed to fetch current user: \(error)"
//                print("Failed to fetch current user:", error)
//                return
//            }
//
//            guard let data = snapshot?.data() else {
//                self.errorMessage = "No data found"
//                return
//
//            }
//            let uid = data["uid"] as? String ?? ""
//            let email = data["email"] as? String ?? ""
//            let displayName = data["displayName"] as? String ?? ""
//            let profilePicture = data["profilePicture"] as? String ?? ""
//            let prayerRequests = data["prayerRequests"] as? [String] ?? []
//            let communities = data["communities"] as? [String] ?? []
//
//
//            self.currentUser = CurrentUser(uid: uid, email: email, displayName: displayName, profilePicture: profilePicture, prayerRequests: prayerRequests, communities: communities)
//        }
    }
}

struct User: Identifiable{
    
    var id: String { uid }
    
    let uid, email, displayName, role, selected: String
    
    init(data: [String: Any]){
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.displayName = data["name"] as? String ?? ""
        self.role = data["role"] as? String ?? ""
        self.selected = data["selected"] as? String ?? ""

    }
    
    init(uid: String, email: String, displayName: String, role: String, selected: String){
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.role = role
        self.selected = selected
    }
}
