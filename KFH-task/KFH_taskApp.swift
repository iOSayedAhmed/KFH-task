//
//  KFH_taskApp.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import SwiftUI

@main
struct KFH_taskApp: App {
    let persistenceController = PersistenceController.shared
    let diContainer = DIContainer.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(diContainer)
        }
    }
}
