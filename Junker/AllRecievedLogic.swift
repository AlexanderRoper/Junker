//
//  AllRecievedLogic.swift
//  Junker
//
//  Created by Xander on 4/23/22.
//

import Firebase

class AllRecievedLogic: ObservableObject{

@Published var recieved = [RecievedRequest]()
    @Published var errorMessage = ""


    init() {
        fetchAllReciepts()
    }

    func fetchAllReciepts() {
        Firestore.firestore().collection("requests").addSnapshotListener{ documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }

                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    self.recieved.append(.init(data: data))
                })
                
                print("\(self.recieved.count)")
            }
    }
    
     func storePick(songUID: String){
        let data = ["recentSong": songUID]
        Firestore.firestore().collection("songManager").document(Auth.auth().currentUser?.uid ?? "------").setData(data) { err in
            if let err = err {
                print(err)
                return
            }
            print("success")
        }
    }
}

struct RecievedRequest: Identifiable {
    var uid: String { id }

    let id, userID, senderName, type, destination : String
    let number: Int
    let puTime: Timestamp
    let completed, approved : Bool
    
    init(data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.userID = data["uid"] as? String ?? ""
        self.type = data["type"] as? String ?? ""
        self.senderName = data["senderName"] as? String ?? ""
        self.completed = data["completed"] as? Bool ?? false
        self.approved = data["approved"] as? Bool ?? false
        self.puTime = data["puTime"] as? Timestamp ?? Timestamp(date: Date.now)
        self.number = data["number"] as? Int ?? -99
        self.destination = data["destination"] as? String ?? ""
    }
}

