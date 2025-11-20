//
//  ContentView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 10/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var posts: [Post]
    
    var body: some View {
        PostListView(posts: posts)
    }
}

#Preview {
    ContentView()
}
