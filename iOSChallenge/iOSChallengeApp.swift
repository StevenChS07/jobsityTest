//
//  iOSChallengeApp.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 1/3/25.
//

import SwiftUI
import RealmSwift

@main
struct iOSChallengeApp: App {
    
    @StateObject private var userViewModel = UserViewModel()
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                        }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(userViewModel)
        }
    }
}
