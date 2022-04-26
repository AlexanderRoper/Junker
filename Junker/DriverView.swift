//
//  DriverView.swift
//  Junker
//
//  Created by Xander on 4/25/22.
//

import SwiftUI
import Firebase

struct DriverView: View {
    @ObservedObject private var uvm = UserViewModel()
    @ObservedObject private var arl = AllRecievedLogic()
    
    var body: some View {
        VStack{
    Spacer()
    VStack{
        Spacer()
        Group{
        Text("Welcome to Junker, ")
            .font(Font.custom("OpenSans-Bold", size: 22.5))
            .foregroundColor(Color(.black))
            +
            Text("\(uvm.currentUser?.displayName ?? "")")
                .font(Font.custom("OpenSans-ExtraBold", size: 22.5))
                .foregroundColor(Color(.black))
        }.shadow(radius: 0.5)
        
        Spacer()
    Text("Assigned Pickups")
            .font(Font.custom("OpenSans-Bold", size: 18))
            .foregroundColor(Color(.black))
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack() {
                ForEach(arl.recieved) {request in
                    VStack{
                        ZStack{
                        Ticket()
                            VStack{
                                Text("\(request.id)")
                                    .font(Font.custom("OpenSans-ExtraBold", size: 7))
                                    .foregroundColor(Color(.white))
                                
                                if request.completed{
                                Text("COMPLETED")
                                    .font(Font.custom("OpenSans-ExtraBold", size: 15))
                                    .foregroundColor(Color(.white))
                                }
                                else if request.approved{
                                    Text("APPROVED")
                                        .font(Font.custom("OpenSans-ExtraBold", size: 15))
                                        .foregroundColor(Color(.white))
                                }
                                
                                else {
                                    Text("PROCESSING")
                                        .font(Font.custom("OpenSans-ExtraBold", size: 15))
                                        .foregroundColor(Color(.white))
                                }
                                
                            }
                        }
                        Button(action: {
                            withAnimation(.linear(duration: 0.3)){
                                Firestore.firestore().collection("requests").whereField("id", isEqualTo: request.id).limit(to: 1).getDocuments(completion: { querySnapshot, error in
                                    if let err = error {
                                        print(err.localizedDescription)
                                        return
                                    }

                                    guard let docs = querySnapshot?.documents else { return }

                                    for doc in docs {
                                        let docId = doc.documentID
                                        let name = doc.get("displayName")
                                        print(docId, name)

                                        let ref = doc.reference
                                        ref.updateData(["completed": true])
                                    }
                                })
                            }
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                        }) {
                            ZStack{
                                
                                Capsule()
                                    .fill(Color("GarbageGreen"))
                                
                                Text("Finished")
                                    .font(Font.custom("OpenSans-Bold", size: 15))
                                    .foregroundColor(.white)
                            }                                    .frame(width: 100, height: 30)
                        }
                    }
                }
            }.offset(x: 10)
        }.frame(width: UIScreen.main.bounds.size.width)
        
        Spacer()
    }
    Spacer()
}
    }
}

struct DriverView_Previews: PreviewProvider {
    static var previews: some View {
        DriverView()
    }
}
