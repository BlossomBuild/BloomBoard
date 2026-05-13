//
//  PostItemView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/5/25.
//

import SwiftUI

struct PostItemView: View {
    let post: Post
    let onSelect: (Post) -> Void
    
    var hasImage: Bool {
        post.image != nil
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                onSelect(post)
            } label: {
                Text(post.title)
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.button)
                    .lineLimit(2)
                    .truncationMode(.tail)
            }
            
            HStack {
                Text("Created \(post.creationDate, style: .date)")
                
                Image(systemName: hasImage ? "photo.artframe" : "document")
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    PostItemView(post: Post.testPosts[1]) { selectedPost in
        
    }
}
