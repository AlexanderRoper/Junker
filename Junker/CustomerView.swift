////
////  CustomerView.swift
////  Junker
////
////  Created by Xander on 4/25/22.
////
//
//import SwiftUI
//
//struct CustomerView: View {
//    @ObservedObject private var arl = AllRecievedLogic()
//    var body: some View {
//        VStack{
//    Spacer()
//    VStack{
//        Group{
//        Text("Welcome to Junker, ")
//            .font(Font.custom("OpenSans-Bold", size: 22.5))
//            .foregroundColor(Color(.black))
//            +
//            Text("\(uvm.currentUser?.displayName ?? "")")
//                .font(Font.custom("OpenSans-ExtraBold", size: 22.5))
//                .foregroundColor(Color(.black))
//        }.shadow(radius: 0.5)
//    Text("Tickets")
//            .font(Font.custom("OpenSans-Bold", size: 18))
//            .foregroundColor(Color(.black))
//
//        ScrollView(.horizontal, showsIndicators: false){
//            HStack() {
//                ForEach(arl.recieved) {request in
//                    ZStack{
//                    Ticket()
//                        VStack{
//                            Text("\(request.type)")
//                                .font(Font.custom("OpenSans-ExtraBold", size: 14))
//                                .foregroundColor(Color(.white))
//
//                            Text("\(request.destination)")
//                                .font(Font.custom("OpenSans-ExtraBold", size: 11))
//                                .foregroundColor(Color(.white))
//
//                            Text("\(request.puTime)")
//                                .font(Font.custom("OpenSans-ExtraBold", size: 11))
//                                .foregroundColor(Color(.white))
//
//                            Text("\(request.id)")
//                                .font(Font.custom("OpenSans-ExtraBold", size: 6.5))
//                                .foregroundColor(Color(.white))
//
//                            if request.completed{
//                            Text("COMPLETED")
//                                .font(Font.custom("OpenSans-ExtraBold", size: 15))
//                                .foregroundColor(Color(.white))
//                            }
//                            else if request.approved{
//                                Text("APPROVED")
//                                    .font(Font.custom("OpenSans-ExtraBold", size: 15))
//                                    .foregroundColor(Color(.white))
//                            }
//
//                            else {
//                                Text("PROCESSING")
//                                    .font(Font.custom("OpenSans-ExtraBold", size: 15))
//                                    .foregroundColor(Color(.white))
//                            }
//
//                        }
//                    }
//                }
//            }.offset(x: 10)
//        }.frame(width: UIScreen.main.bounds.size.width)
//    }
//    Spacer()
//
//    VStack{
//        Text("Request for Service")
//            .font(Font.custom("OpenSans-Bold", size: 18))
//            .foregroundColor(Color(.black))
//                .multilineTextAlignment(.center)
//                .shadow(radius: 0.5)
//            .padding(.bottom, 5)
//
//        uvm.currentUser?.selected ?? "" == "Waste Food" ?
//    ZStack{
//    RoundedRectangle(cornerRadius: 20)
//        .fill(Color(.white))
//        .shadow(radius: 1)
//        VStack{
//            Spacer()
//
//            HStack{
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)){
//                        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Waste Food"]){ err in
//                            if let err = err {
//                                print("Error updating document: \(err)")
//                            } else {
//                                print("Document successfully updated")
//                            }
//                        }
//                    }
//
//                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                        impactMed.impactOccurred()
//                }) {
//                    ZStack{
//                        Text("Waste Food")
//                            .font(Font.custom("OpenSans-Bold", size: 15))
//                            .foregroundColor(uvm.currentUser?.selected ?? "" == "Waste Food" ? Color("GarbageGreen") : Color(.gray))
//                    }
//                }
//                .padding(.trailing, 5)
//
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)){
//                        Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Garbage"]){ err in
//                            if let err = err {
//                                print("Error updating document: \(err)")
//                            } else {
//                                print("Document successfully updated")
//                            }
//                        }
//                    }
//
//                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                        impactMed.impactOccurred()
//                }) {
//                    ZStack{
//                        Text("Garbage")
//                            .font(Font.custom("OpenSans-Bold", size: 15))
//                            .foregroundColor(uvm.currentUser?.selected ?? "" == "Garbage" ? Color("GarbageGreen") : Color(.gray))
//                    }
//                }
//
//            }
//            Spacer()
//            HStack{
//                Text("Pick Up Time")
//                    .font(Font.custom("OpenSans-Bold", size: 18))
//                    .foregroundColor(Color(.black))
//
//                Spacer()
//                DatePicker("Please enter a time", selection: $time)
//
//            }.padding(.horizontal)
//            HStack{
//                Text("Sale Price")
//                    .font(Font.custom("OpenSans-Bold", size: 18))
//                    .foregroundColor(Color(.black))
//                    .frame(width: 90)
//                Spacer()
//                Picker("Enter a price if you wish to sell", selection: $price) {
//                    ForEach(prices, id: \.self) {
//                                    Text("$\($0)")
//                                }
//                            }
//                Spacer()
//            }.padding(.horizontal)
//            HStack{
//                Text("Charity Location")
//                    .font(Font.custom("OpenSans-Bold", size: 18))
//                    .foregroundColor(Color(.black))
//                    .frame(width: 150)
//                Spacer()
//
//                Picker("Choose location", selection: $chosenCharity) {
//                    ForEach(charities, id: \.self) {
//                                    Text("\($0)")
//                                }
//                            }
//
//                Spacer()
//            }.padding(.horizontal)
//            Spacer()
//
//            Button(action: {
//                withAnimation(.linear(duration: 0.3)){
//                    let id = UUID()
//                    Firestore.firestore().collection("requests").addDocument(data: ["id":"\(id)", "senderUid": "\(uvm.currentUser?.uid ?? "")", "type": "\(uvm.currentUser?.selected ?? "")", "senderName": "\(uvm.currentUser?.displayName ?? "")", "completed": false, "approved": false, "puTime": Timestamp(date: time), "number": self.price, "destination": chosenCharity]){ err in
//                        if let err = err {
//                            print("Error updating document: \(err)")
//                        } else {
//                            print("Document successfully updated")
//                        }
//                    }
//                }
//
//                let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                    impactMed.impactOccurred()
//            }) {
//                ZStack{
//
//                    Capsule()
//                        .fill(Color("GarbageGreen"))
//
//                    Text("Submit Ticket")
//                        .font(Font.custom("OpenSans-Bold", size: 15))
//                        .foregroundColor(.white)
//                }                                    .frame(width: 130, height: 30)
//            }
//            Spacer()
//        }
//
////                    TabView(selection: $currentIndex) {
////                        ForEach(0..<1){num in
////                            WebImage(url: URL(string: "asl.song[num].cover"))
////                                    .resizable()
////                                    .aspectRatio(contentMode: .fill)
////                                    .frame(width: 300, height: 300)
////                                    .tag(num)
////
////                            Text(asl.song[num].name)
////                                .foregroundColor(Color("Light"))
////                                .font(Font.custom("EBGaramond-ExtraBold", size: 30))
////                                .shadow(radius: 2, x: 2, y: 2)
////                                .multilineTextAlignment(.center)
////                                .padding(.bottom)
////
////                            Text(asl.song[num].artist)
////                                .foregroundColor(Color("Light"))
////                                .font(Font.custom("OpenSans-Bold", size: 18))
////                                .shadow(radius: 2, x: 2, y: 2)
////                                .multilineTextAlignment(.center)
////                                .padding(.bottom)
////                            }
////                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//
//    }                    .frame(width: UIScreen.main.bounds.width / 1.12, height: 250)
//        :
//        ZStack{
//        RoundedRectangle(cornerRadius: 20)
//            .fill(Color(.white))
//            .shadow(radius: 1)
//            VStack{
//                Spacer()
//
//                HStack{
//                    Button(action: {
//                        withAnimation(.linear(duration: 0.3)){
//                            Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Waste Food"]){ err in
//                                if let err = err {
//                                    print("Error updating document: \(err)")
//                                } else {
//                                    print("Document successfully updated")
//                                }
//                            }
//                        }
//
//                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                            impactMed.impactOccurred()
//                    }) {
//                        ZStack{
//                            Text("Waste Food")
//                                .font(Font.custom("OpenSans-Bold", size: 15))
//                                .foregroundColor(uvm.currentUser?.selected ?? "" == "Waste Food" ? Color("GarbageGreen") : Color(.gray))
//                        }
//                    }
//                    .padding(.trailing, 5)
//
//                    Button(action: {
//                        withAnimation(.linear(duration: 0.3)){
//                            Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").updateData(["selected": "Garbage"]){ err in
//                                if let err = err {
//                                    print("Error updating document: \(err)")
//                                } else {
//                                    print("Document successfully updated")
//                                }
//                            }
//                        }
//
//                        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                            impactMed.impactOccurred()
//                    }) {
//                        ZStack{
//                            Text("Garbage")
//                                .font(Font.custom("OpenSans-Bold", size: 15))
//                                .foregroundColor(uvm.currentUser?.selected ?? "" == "Garbage" ? Color("GarbageGreen") : Color(.gray))
//                        }
//                    }
//
//                }
//                Spacer()
//                HStack{
//                    Text("Pick Up Time")
//                        .font(Font.custom("OpenSans-Bold", size: 18))
//                        .foregroundColor(Color(.black))
//
//                    Spacer()
//                    DatePicker("Please enter a time", selection: $time)
//
//                }.padding(.horizontal)
//                HStack{
//                    Text("Weight (lbs)")
//                        .font(Font.custom("OpenSans-Bold", size: 18))
//                        .foregroundColor(Color(.black))
//                        .frame(width: 110)
//                    Spacer()
//                    Picker("Enter pounds", selection: $weight) {
//                        ForEach(prices, id: \.self) {
//                                        Text("\($0) lbs")
//                                    }
//                                }
//                    Spacer()
//                }.padding(.horizontal)
//                HStack{
//                    Text("Waste Destination")
//                        .font(Font.custom("OpenSans-Bold", size: 18))
//                        .foregroundColor(Color(.black))
//                        .frame(width: 170)
//                    Spacer()
//
//                    Picker("Choose location", selection: $chosenGarbageDestination) {
//                        ForEach(charities, id: \.self) {
//                                        Text("\($0)")
//                                    }
//                                }
//
//                    Spacer()
//                }.padding(.horizontal)
//
//                Spacer()
//
//                Button(action: {
//                    withAnimation(.linear(duration: 0.3)){
//
//                        let id = UUID()
//                        Firestore.firestore().collection("requests").addDocument(data: ["id":"\(id)", "senderUid": "\(uvm.currentUser?.uid ?? "")", "type": "\(uvm.currentUser?.selected ?? "")", "senderName": "\(uvm.currentUser?.displayName ?? "")", "completed": false, "approved": false, "puTime": Timestamp(date: time), "number": self.weight, "destination": chosenGarbageDestination]){ err in
//                            if let err = err {
//                                print("Error updating document: \(err)")
//                            } else {
//                                print("Document successfully updated")
//                            }
//                        }
//                    }
//
//                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
//                        impactMed.impactOccurred()
//                }) {
//                    ZStack{
//
//                        Capsule()
//                            .fill(Color("GarbageGreen"))
//
//                        Text("Submit Ticket")
//                            .font(Font.custom("OpenSans-Bold", size: 15))
//                            .foregroundColor(.white)
//                    }                                    .frame(width: 130, height: 30)
//                }
//                Spacer()
//            }
//
////                    TabView(selection: $currentIndex) {
////                        ForEach(0..<1){num in
////                            WebImage(url: URL(string: "asl.song[num].cover"))
////                                    .resizable()
////                                    .aspectRatio(contentMode: .fill)
////                                    .frame(width: 300, height: 300)
////                                    .tag(num)
////
////                            Text(asl.song[num].name)
////                                .foregroundColor(Color("Light"))
////                                .font(Font.custom("EBGaramond-ExtraBold", size: 30))
////                                .shadow(radius: 2, x: 2, y: 2)
////                                .multilineTextAlignment(.center)
////                                .padding(.bottom)
////
////                            Text(asl.song[num].artist)
////                                .foregroundColor(Color("Light"))
////                                .font(Font.custom("OpenSans-Bold", size: 18))
////                                .shadow(radius: 2, x: 2, y: 2)
////                                .multilineTextAlignment(.center)
////                                .padding(.bottom)
////                            }
////                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
//
//        }                    .frame(width: UIScreen.main.bounds.width / 1.12, height: 250)
//
//
//    }
//    Spacer()
//}
//    }
//}
//
//struct CustomerView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomerView()
//    }
//}
