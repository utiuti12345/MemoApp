//
//  MemoAppApp.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

@main
struct MemoApp_Watch_AppApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
