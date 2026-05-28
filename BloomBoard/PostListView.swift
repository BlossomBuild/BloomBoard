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
    @State private var postDetailPath = NavigationPath()
    @State private var showEditor: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var postToDelete: Post?
    let posts: [Post]
    
    var navigationTitle: String {
        let count = posts.count
        return String(format: "%@ (%d)", "Posts", count)
    }
    
    var body: some View {
        NavigationStack(path: $postDetailPath) {
            List(posts) { post in
                PostItemView(post: post) {selectedPost in
                    postDetailPath.append(selectedPost)
                }
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
            .navigationDestination(for: Post.self, destination: { selectedPost in
                PostDetailView(post: selectedPost)
            })
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
            .navigationTitle(navigationTitle)
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
                PostEditorView(mode: .creating)
            }
        }
    }
}

#Preview {
    PostListView(posts: Post.testPosts)
}
