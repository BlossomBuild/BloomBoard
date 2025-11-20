//
//  PostListView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/20/25.
//

import SwiftUI

struct PostListView: View {
    let posts: [Post]
    
    var body: some View {
        List(posts) { post in
            PostItemView(post: post)
        }
        .overlay {
            if posts.isEmpty {
                ContentUnavailableView("No posts created", systemImage: "tray")
            }
        }
    }
}

#Preview {
    PostListView(posts: Post.testPosts)
}
