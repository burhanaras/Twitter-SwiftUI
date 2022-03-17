//
//  FeedViewModel.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject {
    
    @Published private(set) var users = [User]()
    @Published private(set) var posts = [Post]()
    @Published private(set) var currentUser = User.fromDTO(dto: DummyData.dummyUsers()[0])
    
    @Published var textToTweet = ""
    @Published var errorMessage = ""
    
    private var cancellables: Set<AnyCancellable> = []
    private var networkLayer: INetworkLayer = InMemoryNetworkLayer()
    
    init(networkLayer: INetworkLayer){
        self.networkLayer = networkLayer
        loadData()
    }
    
    func loadData() {
        var _: AnyCancellable? = Publishers.Zip(
            networkLayer.getUsers(),
            networkLayer.getAllPosts()
        )
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        
                    case .finished:
                        break
                    case let .failure(error):
                        print("ERROR Here: \(error.localizedDescription)")
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [unowned self] usersResponse, postsResponse in
                    print("\(usersResponse.count) users downloaded.")
                    self.users = usersResponse.map { User.fromDTO(dto: $0) }
                    self.currentUser = self.users[0]
                    
                    print("\(postsResponse.count) posts downloaded")
                    self.posts = postsResponse.map { Post.fromDTO(dto: $0)}
                }
            )
    }
    
    func post() {
        let post = Post(id: UUID().uuidString, username: currentUser.username, name: currentUser.name, image: currentUser.image, text: self.textToTweet)
        networkLayer.post(user: self.currentUser, post: post)
            .sink { completion in
                switch completion {
                case .finished:
                    self.textToTweet = ""
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
            } receiveValue: { postResponse in
                print(postResponse)
            }
            .store(in: &cancellables)
        
        self.posts.insert(post, at: 0)
    }
    
    func switchToUser(user: User) {
        self.currentUser = user
    }
}
