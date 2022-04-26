//
//  DashboardView.swift
//  Junker
//
//  Created by Xander on 4/19/22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct DashboardView: View {
    @State private var currentIndex = 0
    @AppStorage("appPart") var appPart = 0
    @ObservedObject private var uvm = UserViewModel()
    @ObservedObject private var asl = AllSentLogic()
    @ObservedObject private var arl = AllRecievedLogic()
    @State private var prices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ,13, 14, 15, 16, 17, 18, 19, 20]
    @State private var charities = ["Downtown Homeless", "Food Bank", "Junk Co. Decide"]
    @State private var garbageDestinations = ["Downtown Junkyard", "County Landfill", "Junk Co. Incinerator"]
    @State private var chosenGarbageDestination = "Downtown Junkyard"
    @State private var chosenCharity = "Junk Co. Decide"
    @State private var price = 0
    @State private var weight = 1
    @State private var time = Date.now

    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                HStack{
                    Text("Junker")
                        .font(Font.custom("OpenSans-ExtraBold", size: 22.5))
                    .foregroundColor(Color(.black))
                    .shadow(radius: 0.5)
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.linear(duration: 0.3)){
                            do {
                              try Auth.auth().signOut()
                            } catch let signOutError as NSError {
                              print("Error signing out: %@", signOutError)
                                return
                            }
                            print("Sign out successful")
                            appPart = 0
                        }
                        
                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                    }) {
                        ZStack{
                            Text("Log Out")
                                .font(Font.custom("OpenSans-Bold", size: 15))
                            .foregroundColor(Color(.black))
                        }
                    }
                }
                if uvm.currentUser?.role ?? "" == "Customer" {
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
                Text("Tickets")
                        .font(Font.custom("OpenSans-Bold", size: 18))
                        .foregroundColor(Color(.black))
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack() {
                            ForEach(arl.recieved) {request in
                                ZStack{
                                Ticket()
                                    VStack{
                                        Text("\(request.type)")
                                            .font(Font.custom("OpenSans-ExtraBold", size: 14))
                                            .foregroundColor(Color(.white))
                                        
                                        Text("\(request.destination)")
                                            .font(Font.custom("OpenSans-ExtraBold", size: 11))
                                            .foregroundColor(Color(.white))
                                        
                                        
                                        Text("\(request.puTime.dateValue())")
                                            .font(Font.custom("OpenSans-ExtraBold", size: 11))
                                            .foregroundColor(Color(.white))
                                            .frame(width: 150, alignment: .center)
                                            .multilineTextAlignment(.center)

                                        Text("\(request.id)")
                                            .font(Font.custom("OpenSans-ExtraBold", size: 6.5))
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
                    Text("Request for Service")
                        .font(Font.custom("OpenSans-Bold", size: 18))
                        .foregroundColor(Color(.black))
                            .multilineTextAlignment(.center)
                            .shadow(radius: 0.5)
                        .padding(.bottom, 5)
                    
                    uvm.currentUser?.selected ?? "" == "Waste Food" ?
                ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.white))
                    .shadow(radius: 1)
                    VStack{
                        Spacer()
                        
                        HStack{
                            Button(action: {
                                withAnimation(.linear(duration: 0.3)){
                                    Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Waste Food"]){ err in
                                        if let err = err {
                                            print("Error updating document: \(err)")
                                        } else {
                                            print("Document successfully updated")
                                        }
                                    }
                                }
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                            }) {
                                ZStack{
                                    Text("Waste Food")
                                        .font(Font.custom("OpenSans-Bold", size: 15))
                                        .foregroundColor(uvm.currentUser?.selected ?? "" == "Waste Food" ? Color("GarbageGreen") : Color(.gray))
                                }
                            }
                            .padding(.trailing, 5)
                                                        
                            Button(action: {
                                withAnimation(.linear(duration: 0.3)){
                                    Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Garbage"]){ err in
                                        if let err = err {
                                            print("Error updating document: \(err)")
                                        } else {
                                            print("Document successfully updated")
                                        }
                                    }
                                }
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                            }) {
                                ZStack{
                                    Text("Garbage")
                                        .font(Font.custom("OpenSans-Bold", size: 15))
                                        .foregroundColor(uvm.currentUser?.selected ?? "" == "Garbage" ? Color("GarbageGreen") : Color(.gray))
                                }
                            }

                        }
                        Spacer()
                        HStack{
                            Text("Pick Up Time")
                                .font(Font.custom("OpenSans-Bold", size: 18))
                                .foregroundColor(Color(.black))
                            
                            Spacer()
                            DatePicker("Please enter a time", selection: $time)

                        }.padding(.horizontal)
                        HStack{
                            Text("Sale Price")
                                .font(Font.custom("OpenSans-Bold", size: 18))
                                .foregroundColor(Color(.black))
                                .frame(width: 90)
                            Spacer()
                            Picker("Enter a price if you wish to sell", selection: $price) {
                                ForEach(prices, id: \.self) {
                                                Text("$\($0)")
                                            }
                                        }
                            Spacer()
                        }.padding(.horizontal)
                        HStack{
                            Text("Charity Location")
                                .font(Font.custom("OpenSans-Bold", size: 18))
                                .foregroundColor(Color(.black))
                                .frame(width: 150)
                            Spacer()

                            Picker("Choose location", selection: $chosenCharity) {
                                ForEach(charities, id: \.self) {
                                                Text("\($0)")
                                            }
                                        }
                            
                            Spacer()
                        }.padding(.horizontal)
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.linear(duration: 0.3)){
                                let id = UUID()
                                Firestore.firestore().collection("requests").addDocument(data: ["id":"\(id)", "senderUid": "\(uvm.currentUser?.uid ?? "")", "type": "\(uvm.currentUser?.selected ?? "")", "senderName": "\(uvm.currentUser?.displayName ?? "")", "completed": false, "approved": false, "puTime": Timestamp(date: time), "number": self.price, "destination": chosenCharity]){ err in
                                    if let err = err {
                                        print("Error updating document: \(err)")
                                    } else {
                                        print("Document successfully updated")
                                    }
                                }
                            }
                            
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                impactMed.impactOccurred()
                        }) {
                            ZStack{
                                
                                Capsule()
                                    .fill(Color("GarbageGreen"))
                                
                                Text("Submit Ticket")
                                    .font(Font.custom("OpenSans-Bold", size: 15))
                                    .foregroundColor(.white)
                            }                                    .frame(width: 130, height: 30)
                        }
                        Spacer()
                    }
                    
//                    TabView(selection: $currentIndex) {
//                        ForEach(0..<1){num in
//                            WebImage(url: URL(string: "asl.song[num].cover"))
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(width: 300, height: 300)
//                                    .tag(num)
//
//                            Text(asl.song[num].name)
//                                .foregroundColor(Color("Light"))
//                                .font(Font.custom("EBGaramond-ExtraBold", size: 30))
//                                .shadow(radius: 2, x: 2, y: 2)
//                                .multilineTextAlignment(.center)
//                                .padding(.bottom)
//
//                            Text(asl.song[num].artist)
//                                .foregroundColor(Color("Light"))
//                                .font(Font.custom("OpenSans-Bold", size: 18))
//                                .shadow(radius: 2, x: 2, y: 2)
//                                .multilineTextAlignment(.center)
//                                .padding(.bottom)
//                            }
//                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                }                    .frame(width: UIScreen.main.bounds.width / 1.12, height: 250)
                    :
                    ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.white))
                        .shadow(radius: 1)
                        VStack{
                            Spacer()
                            
                            HStack{
                                Button(action: {
                                    withAnimation(.linear(duration: 0.3)){
                                        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Waste Food"]){ err in
                                            if let err = err {
                                                print("Error updating document: \(err)")
                                            } else {
                                                print("Document successfully updated")
                                            }
                                        }
                                    }
                                    
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                        impactMed.impactOccurred()
                                }) {
                                    ZStack{
                                        Text("Waste Food")
                                            .font(Font.custom("OpenSans-Bold", size: 15))
                                            .foregroundColor(uvm.currentUser?.selected ?? "" == "Waste Food" ? Color("GarbageGreen") : Color(.gray))
                                    }
                                }
                                .padding(.trailing, 5)
                                                            
                                Button(action: {
                                    withAnimation(.linear(duration: 0.3)){
                                        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Garbage"]){ err in
                                            if let err = err {
                                                print("Error updating document: \(err)")
                                            } else {
                                                print("Document successfully updated")
                                            }
                                        }
                                    }
                                    
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                        impactMed.impactOccurred()
                                }) {
                                    ZStack{
                                        Text("Garbage")
                                            .font(Font.custom("OpenSans-Bold", size: 15))
                                            .foregroundColor(uvm.currentUser?.selected ?? "" == "Garbage" ? Color("GarbageGreen") : Color(.gray))
                                    }
                                }

                            }
                            Spacer()
                            HStack{
                                Text("Pick Up Time")
                                    .font(Font.custom("OpenSans-Bold", size: 18))
                                    .foregroundColor(Color(.black))
                                
                                Spacer()
                                DatePicker("Please enter a time", selection: $time)

                            }.padding(.horizontal)
                            HStack{
                                Text("Weight (lbs)")
                                    .font(Font.custom("OpenSans-Bold", size: 18))
                                    .foregroundColor(Color(.black))
                                    .frame(width: 110)
                                Spacer()
                                Picker("Enter pounds", selection: $weight) {
                                    ForEach(prices, id: \.self) {
                                                    Text("\($0) lbs")
                                                }
                                            }
                                Spacer()
                            }.padding(.horizontal)
                            HStack{
                                Text("Waste Destination")
                                    .font(Font.custom("OpenSans-Bold", size: 18))
                                    .foregroundColor(Color(.black))
                                    .frame(width: 170)
                                Spacer()

                                Picker("Choose location", selection: $chosenGarbageDestination) {
                                    ForEach(charities, id: \.self) {
                                                    Text("\($0)")
                                                }
                                            }
                                
                                Spacer()
                            }.padding(.horizontal)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation(.linear(duration: 0.3)){
                                    
                                    let id = UUID()
                                    Firestore.firestore().collection("requests").addDocument(data: ["id":"\(id)", "senderUid": "\(uvm.currentUser?.uid ?? "")", "type": "\(uvm.currentUser?.selected ?? "")", "senderName": "\(uvm.currentUser?.displayName ?? "")", "completed": false, "approved": false, "puTime": Timestamp(date: time), "number": self.weight, "destination": chosenGarbageDestination]){ err in
                                        if let err = err {
                                            print("Error updating document: \(err)")
                                        } else {
                                            print("Document successfully updated")
                                        }
                                    }
                                }
                                
                                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                            }) {
                                ZStack{
                                    
                                    Capsule()
                                        .fill(Color("GarbageGreen"))
                                    
                                    Text("Submit Ticket")
                                        .font(Font.custom("OpenSans-Bold", size: 15))
                                        .foregroundColor(.white)
                                }                                    .frame(width: 130, height: 30)
                            }
                            Spacer()
                        }
                        
    //                    TabView(selection: $currentIndex) {
    //                        ForEach(0..<1){num in
    //                            WebImage(url: URL(string: "asl.song[num].cover"))
    //                                    .resizable()
    //                                    .aspectRatio(contentMode: .fill)
    //                                    .frame(width: 300, height: 300)
    //                                    .tag(num)
    //
    //                            Text(asl.song[num].name)
    //                                .foregroundColor(Color("Light"))
    //                                .font(Font.custom("EBGaramond-ExtraBold", size: 30))
    //                                .shadow(radius: 2, x: 2, y: 2)
    //                                .multilineTextAlignment(.center)
    //                                .padding(.bottom)
    //
    //                            Text(asl.song[num].artist)
    //                                .foregroundColor(Color("Light"))
    //                                .font(Font.custom("OpenSans-Bold", size: 18))
    //                                .shadow(radius: 2, x: 2, y: 2)
    //                                .multilineTextAlignment(.center)
    //                                .padding(.bottom)
    //                            }
    //                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        
                    }                    .frame(width: UIScreen.main.bounds.width / 1.12, height: 250)

                    
                }
                Spacer()
            }
                }
                else if uvm.currentUser?.role ?? "" == "Admin"{
                    AdminView()
                }
                
                else if uvm.currentUser?.role ?? "" == "Driver"{
                    DriverView()

                }
                Group{
                Text("Account Type: ")
                    .font(Font.custom("OpenSans-Bold", size: 22.5))
                    .foregroundColor(Color(.black))
                    +
                    
                    Text("\(uvm.currentUser?.role ?? "")")
                        .font(Font.custom("OpenSans-ExtraBold", size: 22.5))
                        .foregroundColor(Color(.black))
                }
            }.frame(width: UIScreen.main.bounds.width / 1.12)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

struct Ticket: View{
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("GarbageGreen"))
            .frame(width: 150, height: 200)
            .shadow(radius: 1)
            .padding(10)
    }
}
