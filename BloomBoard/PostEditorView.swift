//
//  PostEditorView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/28/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PostEditorView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var postImage: UIImage? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title, axis: .vertical)
                    .padding(.horizontal)
                    .bold()
                
                Rectangle()
                    .frame(height: 2)
                    .padding(.horizontal)
                
                PhotosPicker(selection: $selectedImage, matching: .images) {
                    if let image = postImage {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: 220)
                                .padding()
                            
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .padding()
                                    .background(.ultraThinMaterial, in: Circle())
                                    .foregroundStyle(.button)
                                
                                Button {
                                    selectedImage = nil
                                    postImage = nil
                                } label: {
                                    Image(systemName: "trash")
                                        .padding()
                                        .background(.ultraThinMaterial, in: Circle())
                                        .foregroundStyle(.button)
                                }
                            }
                        }
                    } else {
                        Text("Upload Image")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity, maxHeight: 220)
                            .background(.ultraThinMaterial)
                            .clipShape(.rect(cornerRadius: 10))
                            .padding()
                    }
                }
                .onChange(of: selectedImage) { _, newValue in
                    Task {
                        guard let data = try? await newValue?.loadTransferable(type: Data.self) else { return }
                        
                        await MainActor.run {
                            postImage = UIImage(data: data)
                        }
                    }
                }
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newPost = Post(title: title)
                        
                        if let imageData = postImage?.jpegData(compressionQuality: 0.90) {
                            newPost.image = imageData
                        }
                        modelContext.insert(newPost)
                        try? modelContext.save()
                        dismiss()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    PostEditorView()
}
