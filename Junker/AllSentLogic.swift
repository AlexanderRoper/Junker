//
//  AllRequestsLogic.swift
//  Junker
//
//  Created by Xander on 4/23/22.
//

import Firebase

class AllSentLogic: ObservableObject{

@Published var sent = [SentRequest]()
    @Published var errorMessage = ""


    init() {
        fetchAllSends()
    }

    func fetchAllSends() {
        Firestore.firestore().collection("requests").document(Auth.auth().currentUser?.uid ?? "").collection("sent").getDocuments{ documentsSnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch users: \(error)"
                    print("Failed to fetch users: \(error)")
                    return
                }

                documentsSnapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    self.sent.append(.init(data: data))
                })
                
                print("\(self.sent.count)")
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

struct SentRequest: Identifiable {
    var uid: String { id }

    let id, senderName, type, puTime, destination : String
    let number: Int
    let completed : Bool
    
    init(data: [String: Any]){
        self.id = data["id"] as? String ?? ""
        self.type = data["type"] as? String ?? ""
        self.senderName = data["senderName"] as? String ?? ""
        self.completed = data["completed"] as? Bool ?? false
        self.puTime = data["puTime"] as? String ?? ""
        self.number = data["number"] as? Int ?? -99
        self.destination = data["destination"] as? String ?? ""
    }
}
