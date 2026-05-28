//
//  ContentView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 10/15/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: [SortDescriptor(\Post.creationDate, order: .reverse)])
    var posts: [Post]
    
    var body: some View {
        PostListView(posts: posts)
    }
}

#Preview {
    ContentView()
}
