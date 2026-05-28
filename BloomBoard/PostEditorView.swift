//
//  PostEditorView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/28/25.
//

import SwiftUI
import PhotosUI
import SwiftData

enum EditorMode {
    case creating
    case editing(Post)
}

struct PostEditorView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var postImage: UIImage? = nil
    @State private var didImageChange: Bool = false
    @FocusState private var titleFocus: Bool
    let mode: EditorMode
    
    var navigationTitle: String {
        switch mode {
        case .creating:
            return "New Post"
        case .editing:
            return "Edit Post"
        }
    }
    
    init(mode: EditorMode) {
        self.mode = mode
        
        switch mode {
        case .creating:
            title = ""
        case .editing(let post):
            title = post.title
            
            if let data = post.image {
                _postImage = State(initialValue: UIImage(data: data))
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title, axis: .vertical)
                    .padding(.horizontal)
                    .bold()
                    .focused($titleFocus)
                
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
                                    didImageChange = true
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
                            didImageChange = true
                        }
                    }
                }
            }
            .onAppear {
                titleFocus = true
            }
            .navigationTitle(navigationTitle)
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
                        saveButtonAction()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveButtonAction() {
        switch mode {
        case .creating:
            let newPost = Post(title: title)
            
            if let imageData = postImage?.jpegData(compressionQuality: 0.90) {
                newPost.image = imageData
            }
            modelContext.insert(newPost)
            
        case .editing(let post):
            post.title = title
            
            if didImageChange {
                post.image = postImage?.jpegData(compressionQuality: 0.90)
            }
        }
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
        }
    }
}

#Preview {
    PostEditorView(mode: .creating)
}
