//
//  JunkerApp.swift
//  Junker
//
//  Created by Xander on 3/22/22.
//

import SwiftUI
import Firebase

@main
struct JunkerApp: App {
    @AppStorage("appPart") var appPart = 0
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if appPart == 0{
                LogInView()
            }
            if appPart == 1{
                DashboardView()
            }
        }
    }
}
