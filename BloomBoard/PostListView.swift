//
//  PostListView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/20/25.
//

import SwiftUI
import SwiftData

struct PostListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showEditor: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var postToDelete: Post?
    let posts: [Post]
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                PostItemView(post: post)
                    .swipeActions(edge: .trailing) {
                        Button {
                            showDeleteAlert = true
                            postToDelete = post
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
            }
            .overlay {
                if posts.isEmpty {
                    ContentUnavailableView("No posts created", systemImage: "tray")
                }
            }
            .alert("Delete post?", isPresented: $showDeleteAlert, actions: {
                Button("Cancel", role: .cancel) {
                    postToDelete = nil
                }
                
                Button("Continue", role: .destructive) {
                    if let post = postToDelete {
                        modelContext.delete(post)
                    }
                }
            })
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
