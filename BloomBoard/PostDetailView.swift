//
//  PostDetailView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 5/6/26.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    var postImage: UIImage? {
        guard let imageData = post.image else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(post.title)
                    .padding(.horizontal)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                
                if let image = postImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                        .frame(maxHeight: 250)
                } else {
                    Text("No image")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                    }

                }
            }
        }
    }
}

#Preview {
    PostDetailView(post: Post.testPosts[0])
}
