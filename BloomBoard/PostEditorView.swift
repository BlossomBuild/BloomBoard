//
//  PostEditorView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/28/25.
//

import SwiftUI
import PhotosUI

struct PostEditorView: View {
    @State private var title: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            TextField("Title", text: $title, axis: .vertical)
                .padding(.horizontal)
                .bold()
            
            Rectangle()
                .frame(height: 2)
                .padding(.horizontal)
            
            PhotosPicker(selection: $selectedImage, matching: .images) {
                Text("Upload Image")
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, maxHeight: 220)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
            }
        }
    }
}

#Preview {
    PostEditorView()
}
