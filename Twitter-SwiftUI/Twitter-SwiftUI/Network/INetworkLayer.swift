//
//  INetworkLayer.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Combine


protocol INetworkLayer {
    func getUsers() -> AnyPublisher<[UserDTO], RequestError>
    func getAllPosts() -> AnyPublisher<[PostDTO], RequestError>
    func post(user: User, post: Post) -> AnyPublisher<Bool, RequestError>
}

class InMemoryNetworkLayer: INetworkLayer {
    
    private var data = [PostDTO]()
    
    func getUsers() -> AnyPublisher<[UserDTO], RequestError> {
        return Result<[UserDTO], RequestError>
            .Publisher(.success(DummyData.dummyUsers()))
            .eraseToAnyPublisher()
    }
    
    func getAllPosts() -> AnyPublisher<[PostDTO], RequestError> {
        return Result<[PostDTO], RequestError>
            .Publisher(.success(data))
            .eraseToAnyPublisher()
    }
    
    func post(user: User, post: Post) -> AnyPublisher<Bool, RequestError> {
        let dto = PostDTO(id: post.id, text: post.text, user: UserDTO(id: user.id, username: user.username, name: user.name, image: user.image))
        self.data.append(dto)
        
        return Result<Bool, RequestError>
            .Publisher(.success(true))
            .eraseToAnyPublisher()
    }
}
