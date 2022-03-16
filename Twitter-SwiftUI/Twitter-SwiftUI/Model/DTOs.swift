//
//  DTOs.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Foundation


struct UserDTO: Codable {
    let id: String
    let username: String
    let name: String
    let image: String
}

struct PostDTO: Codable {
    let id: String
    let text: String
    let user: UserDTO
}
