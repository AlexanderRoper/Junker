//
//  AdminView.swift
//  Junker
//
//  Created by Xander on 4/25/22.
//

import SwiftUI
import Firebase

struct AdminView: View {
    @ObservedObject private var uvm = UserViewModel()
    @ObservedObject private var arl = AllRecievedLogic()
    var body: some View {
        VStack{
    Spacer()
    VStack{
        Group{
        Text("Welcome to Junker, ")
            .font(Font.custom("OpenSans-Bold", size: 22.5))
            .foregroundColor(Color(.black))
            +
            Text("\(uvm.currentUser?.displayName ?? "")")
                .font(Font.custom("OpenSans-ExtraBold", size: 22.5))
                .foregroundColor(Color(.black))
        }.shadow(radius: 0.5)
    Text("Status of Approved ")
            .font(Font.custom("OpenSans-Bold", size: 18))
            .foregroundColor(Color(.black))
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(arl.recieved) {request in
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
                    
                }
            }.offset(x: 10)
        }.frame(width: UIScreen.main.bounds.size.width)
    }
    Spacer()
    
    VStack{
        Text("New Requests")
            .font(Font.custom("OpenSans-Bold", size: 18))
            .foregroundColor(Color(.black))
                .multilineTextAlignment(.center)
                .shadow(radius: 0.5)
            .padding(.bottom, 5)
        ScrollView(.horizontal, showsIndicators: false){
            HStack() {
                ForEach(arl.recieved) {request in
                    if request.approved != true{
    ZStack{
    RoundedRectangle(cornerRadius: 20)
        .fill(Color(.white))
        .shadow(radius: 1)
        VStack{
            Spacer()
            
            HStack{
                Text(request.type)
                    .font(Font.custom("OpenSans-Bold", size: 15))
                    .foregroundColor(Color("GreenGarbage"))
            }
            Spacer()
            HStack{
                Text("Ticket ID")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))
                
                Text("\(request.id)")
                    .font(Font.custom("OpenSans-ExtraBold", size: 10))
                    .foregroundColor(Color(.black))                       }.padding(.horizontal)
            HStack{
                Text("Pick up Time")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))
                
                Text("\(request.puTime.dateValue())")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))
                    .frame(width: 150, alignment: .center)
                    .multilineTextAlignment(.center)


            }.padding(.horizontal)
            HStack{
                Text("Sale Price")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))

                Text("\(request.number)")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))                        }.padding(.horizontal)
            HStack{
                Text("Charity Location")
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))
                
                Text(request.destination)
                    .font(Font.custom("OpenSans-Bold", size: 18))
                    .foregroundColor(Color(.black))                        }.padding(.horizontal)
            Spacer()
            
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
                            ref.updateData(["approved": true])
                        }
                    })
                }
                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                    impactMed.impactOccurred()
            }) {
                ZStack{
                    
                    Capsule()
                        .fill(Color("GarbageGreen"))
                    
                    Text("Approve")
                        .font(Font.custom("OpenSans-Bold", size: 15))
                        .foregroundColor(.white)
                }                                    .frame(width: 130, height: 30)
            }
            Spacer()
        }
        
    }.padding(10)
        .frame(width: UIScreen.main.bounds.width / 1.12, height: 250)
                    }
                }
            }.offset(x: 10)
        }.frame(width: UIScreen.main.bounds.size.width)
    }
    Spacer()
}
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
