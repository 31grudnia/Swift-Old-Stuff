//
//  Projekt1App.swift
//  Projekt1
//
//  Created by Mikołaj Starczewski on 18/06/2022.
//

import SwiftUI

@main
struct Projekt1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
