//
//  psimobileApp.swift
//  psimobile
//
//  Created by Makafui Aheto on 24/09/2021.
//

import SwiftUI
import Firebase


@main
struct psimobileApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            
            if (Auth.auth().currentUser != nil){
                Home_Screen()
            }else{
                
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(UserAuthentication())
                
            }
            
        }
    }
}
