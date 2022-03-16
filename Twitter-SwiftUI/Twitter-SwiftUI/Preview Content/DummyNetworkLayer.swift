//
//  DummyNetworkLayer.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Combine


class DummyNetworkLayer: INetworkLayer {
    
    func getUsers() -> AnyPublisher<[UserDTO], RequestError> {
        return Result<[UserDTO], RequestError>
            .Publisher(.success(DummyData.dummyUsers()))
            .eraseToAnyPublisher()
    }
    
    func getAllPosts() -> AnyPublisher<[PostDTO], RequestError> {
        return Result<[PostDTO], RequestError>
            .Publisher(.success(DummyData.dummyData(count: 10)))
            .eraseToAnyPublisher()
    }
    
    func post(user: User, post: Post) -> AnyPublisher<Bool, RequestError> {
        return Result<Bool, RequestError>
            .Publisher(.success(true))
            .eraseToAnyPublisher()
    }
}

class DummyFailingNetworkLayer: INetworkLayer {
    
    func getUsers() -> AnyPublisher<[UserDTO], RequestError> {
        return Result<[UserDTO], RequestError>
            .Publisher(.failure(.apiError))
            .eraseToAnyPublisher()
    }
    
    func getAllPosts() -> AnyPublisher<[PostDTO], RequestError> {
        return Result<[PostDTO], RequestError>
            .Publisher(.failure(.apiError))
            .eraseToAnyPublisher()
    }
    
    func post(user: User, post: Post) -> AnyPublisher<Bool, RequestError> {
        return Result<Bool, RequestError>
            .Publisher(.success(false))
            .eraseToAnyPublisher()
    }
}
