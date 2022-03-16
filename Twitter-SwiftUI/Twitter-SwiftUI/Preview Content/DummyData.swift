//
//  DummyData.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Foundation

class DummyData {
    
    static func dummyUsers() -> [UserDTO] {
        let user0 =  UserDTO(id: "0", username: "@user0", name: "User 0 Name", image: "person.crop.circle.fill")
        let user1 =  UserDTO(id: "0", username: "@user0", name: "User 0 Name", image: "person.crop.circle.fill")
        let user2 =  UserDTO(id: "0", username: "@user0", name: "User 0 Name", image: "person.crop.circle.fill")
        return [user0, user1, user2]
    }

    static func dummyData(count: Int) -> [PostDTO] {
        var data = [PostDTO]()
        for index in 0..<count {
            let dto = PostDTO(
                id: "\(index)",
                text: "After he and his wife are murdered, marine Ray Garrison is resurrected by a team of scientists. Enhanced with nanotechnology, he becomes a superhuman, biotech killing machine—'Bloodshot'.",
                user: dummyUsers()[0])
            data.append(dto)
        }
        
        return data
    }

}
