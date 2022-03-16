//
//  DummyData.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Foundation

class DummyData {
    
    static func dummyUsers() -> [UserDTO] {
        let user0 =  UserDTO(id: "0", username: "user0", name: "Ahmet Kaya", image: "person.crop.circle.fill")
        let user1 =  UserDTO(id: "1", username: "user1", name: "Yılmaz Güney", image: "person.crop.circle.fill")
        let user2 =  UserDTO(id: "2", username: "user2", name: "Kadir İnanır", image: "person.crop.circle.fill")
        return [user0, user1, user2]
    }

    static func dummyData(count: Int) -> [PostDTO] {
        var data = [PostDTO]()
        for index in 0..<count {
            var dto = PostDTO(
                id: UUID().uuidString,
                text: "The Shiba Inu token is our foundational currency that allows investors to hold millions, billions, or even trillions, of it in their wallets.",
                user: dummyUsers()[0])
            data.append(dto)
            
            dto = PostDTO(
                id: UUID().uuidString,
                text: "Chancellor on Brink of Second Bailout for Banks. Chancellor on Brink of Second Bailout for Banks.",
                user: dummyUsers()[1])
            data.append(dto)
            
            dto = PostDTO(
                id: UUID().uuidString,
                text: "The satoshi is not the only subdivision of bitcoin. A millibitcoin is a term for one-thousandth of a bitcoin or 0.001 BTC. A microbitcoin is one-millionth of a bitcoin or 0.000001 BTC. On the Lightning network, it is possible to transact using a unit even smaller than the satoshi.",
                user: dummyUsers()[2])
            data.append(dto)
        }
        
        return data
    }

}
