//
//  Post.swift
//  BloomBoard
//
//  Created by Carlos Valentin on 10/15/25.
//

import Foundation
import SwiftData

@Model
class Post: Identifiable {
    var id: UUID
    var title: String
    var image: Data?
    var creationDate: Date
    
    init(id: UUID = UUID(), title: String, image: Data? = nil, creationDate: Date = Date()) {
        self.id = id
        self.title = title
        self.image = image
        self.creationDate = creationDate
    }
}
