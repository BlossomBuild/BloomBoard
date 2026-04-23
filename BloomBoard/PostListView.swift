//
//  PostListView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/20/25.
//

import SwiftUI

struct PostListView: View {
    @State private var showEditor: Bool = false
    let posts: [Post]
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                PostItemView(post: post)
            }
            .overlay {
                if posts.isEmpty {
                    ContentUnavailableView("No posts created", systemImage: "tray")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showEditor = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showEditor) {
                PostEditorView()
            }
        }
    }
}

#Preview {
    PostListView(posts: Post.testPosts)
}
