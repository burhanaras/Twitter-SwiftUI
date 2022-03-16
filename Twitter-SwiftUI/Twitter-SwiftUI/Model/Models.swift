//
//  Models.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Foundation

struct User: Identifiable {
    let id: String
    let username: String
    let name: String
    let image: String
}

extension User {
    static func fromDTO(dto: UserDTO) -> User {
        return User(id: dto.id, username: dto.username, name: dto.name, image: dto.image)
    }
}

struct Post: Identifiable {
    let id: String
    let username: String
    let name: String
    let image: String
    let text: String
}

extension Post {
    static func fromDTO(dto: PostDTO) -> Post {
        return Post(id: dto.id, username: dto.user.username, name: dto.user.name, image: dto.user.image, text: dto.text)
    }
}
