//
//  PostEditorView.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 11/28/25.
//

import SwiftUI

struct PostEditorView: View {
    @State private var title: String = ""
    
    var body: some View {
        VStack {
            TextField("Title", text: $title, axis: .vertical)
                .padding(.horizontal)
                .bold()
            
            Rectangle()
                .frame(height: 2)
                .padding(.horizontal)
        }
    }
}

#Preview {
    PostEditorView()
}
