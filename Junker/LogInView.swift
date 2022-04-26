//
//  ContentView.swift
//  Junker
//
//  Created by Xander on 3/22/22.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @State var email = ""
    @State var password = ""
    @AppStorage("appPart") var appPart = 0
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            VStack{
                
                Spacer()
                    
                HStack {
                    Text("Junker")
                        .font(Font.custom("OpenSans-ExtraBold", size: 65))
                    .foregroundColor(Color(.black))
                        
                    Image(systemName: "trash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 66, height: 65)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(Color(.black))
                        .padding(.leading, 5)
                }.shadow(radius: 1)
                    
                Spacer()
                
                Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: $password).foregroundColor(.black)
                    
                }.padding(12)
                 .background(Color.white)
                 .shadow(radius: 1)
                 .cornerRadius(20)
                
                Spacer()
                
                Button(action: {
                    Auth.auth().signIn(withEmail: email, password: password) { (result, error)
                        in if let err = error {
                            print("\(err)")
                        }
                        
                        if result != nil{
                        appPart += 1
                        print(appPart)
                        }
                    }
                        
                    
                }) {
                    
                    ZStack{
                        
                        Capsule()
                            .fill(Color("GarbageGreen"))
                        
                        Text("Login")
                            .font(Font.custom("OpenSans-Bold", size: 20))
                            .foregroundColor(.white)
                    }                                    .frame(width: 150, height: 55)
                }
                
                Spacer()
                
            }.padding()

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
