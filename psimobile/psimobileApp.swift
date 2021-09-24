//
//  psimobileApp.swift
//  psimobile
//
//  Created by Makafui Aheto on 24/09/2021.
//

import SwiftUI

@main
struct psimobileApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
