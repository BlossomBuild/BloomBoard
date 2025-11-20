//
//  BloomBoardApp.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 10/16/25.
//

import SwiftUI
import SwiftData

@main
struct BloomBoardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Post.self)
    }
}
