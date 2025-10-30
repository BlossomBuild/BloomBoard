//
//  Post.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 10/15/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Post: Identifiable {
    private(set) var id: UUID
    var title: String
    @Attribute(.externalStorage) var image: Data?
    private(set) var creationDate: Date
    
    init(title: String, image: Data? = nil) {
        self.id = UUID()
        self.title = title
        self.image = image
        self.creationDate = Date()
    }
    
    static var testPosts = [
        Post(title: "AI loves to add more code than needed"),
        Post(title: "Is MVVM needed in SwiftUI?", image: UIImage(named: "Test1")?.jpegData(compressionQuality: 0.90)),
        Post(title: "How do you write buttons in SwiftUI?", image: UIImage(named: "Test2")?.jpegData(compressionQuality: 0.90))
    ]
}
