//
//  PostItemView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/5/25.
//

import SwiftUI

struct PostItemView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .bold()
                .font(.title3)
            
            Text("Created \(post.creationDate, style: .date)")
        }
    }
}

#Preview {
    PostItemView(post: Post.testPosts[0])
}
