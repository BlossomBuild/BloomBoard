//
//  PostItemView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/5/25.
//

import SwiftUI

struct PostItemView: View {
    let post: Post
    
    var hasImage: Bool {
        post.image != nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .bold()
                .font(.title3)
            
            HStack {
                Text("Created \(post.creationDate, style: .date)")
                
                Image(systemName: hasImage ? "photo.artframe" : "document")
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PostItemView(post: Post.testPosts[1])
}
