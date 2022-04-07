//
//  ContentView.swift
//  Junker
//
//  Created by Xander on 3/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            VStack{
                
                Spacer()
                    
                HStack {
                    Text("Junker").foregroundColor(Color(.black)).font(Font.custom("", size: 65))
                        
                    Image(systemName: "trash.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 66, height: 65)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(Color(.black))
                        .padding(.leading, 5)
                }
                    
                Spacer()
                
                Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $password)
                    
                }.padding(12)
                 .background(Color.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    VStack {
                        Text("LOGIN")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color("LoginButton"))
                            .cornerRadius(15.0)
                    }.padding()
                }
                
                Spacer()
                
            }.padding()

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
