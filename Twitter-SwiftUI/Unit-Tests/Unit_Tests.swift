//
//  Unit_Tests.swift
//  Unit-Tests
//
//  Created by Burhan Aras on 17.03.2022.
//

import XCTest
import Combine
@testable import Twitter_SwiftUI

class Unit_Tests: XCTestCase {

    func test_FeedViewModel_should_show_posts_correctly_when_network_returns_successful_posts_data() {
        // GIVEN: that we have a network layer that returns some posts
        let posts = makePostsData(count: 5)
        let networkLayer: INetworkLayer = InMemoryNetworkLayer(initialData: posts)
        
        // WHEN: FeedViewModel is created
        let sut = FeedViewModel(networkLayer: networkLayer)
        
        // THEN: FeedViewModel's data should be same as network data
        XCTAssertEqual(sut.posts.count, posts.count)
    }

    func test_FeedViewModel_should_show_empty_data_when_network_returns_no_posts() {
        // GIVEN: that we have a network layer that returns no posts
        let networkLayer: INetworkLayer = InMemoryNetworkLayer()
        
        // WHEN: FeedViewModel is created
        let sut = FeedViewModel(networkLayer: networkLayer)
        
        // THEN: FeedViewModel's data should be same as network data
        XCTAssertEqual(sut.posts.count, 0)
    }
    
    func test_FeedViewModel_should_show_3_users_correctly_when_network_returns_successful_users_data() {
        // GIVEN: that we have a network layer that returns some posts
        let networkLayer: INetworkLayer = InMemoryNetworkLayer()
        
        // WHEN: FeedViewModel is created
        let sut = FeedViewModel(networkLayer: networkLayer)
        
        // THEN: FeedViewModel's data should be same as network data
        let expected = 3
        XCTAssertEqual(sut.users.count, expected)
    }
    
    func test_FedViewModel_should_show_error_message_when_network_fails_to_load_posts(){
        // GIVEN: that we have a failing network layer
        let postsResponse: Result<[PostDTO], RequestError> = .failure(.apiError)
        let usersResponse: Result<[UserDTO], RequestError> = .success(makeUsersData())
        let networkLayer: INetworkLayer = TestNetworkLayer(usersResponse: usersResponse, postsResponse: postsResponse)
        let sut = FeedViewModel(networkLayer: networkLayer)
        
        // WHEN: loadData() of FeedViewModel is called
        sut.loadData()
        
        // THEN: FeedViewModel's error message must be correct and posts should be empty
        XCTAssertEqual(0, sut.users.count)
        XCTAssertEqual(0, sut.posts.count)
        XCTAssertEqual(RequestError.apiError.localizedDescription, sut.errorMessage)
    }
    
    func test_FedViewModel_should_show_error_message_when_network_fails_to_load_users(){
        // GIVEN: that we have a failing network layer
        let usersResponse: Result<[UserDTO], RequestError> = .failure(.apiError)
        let postsResponse: Result<[PostDTO], RequestError> = .success(makePostsData(count: 10))
        let networkLayer: INetworkLayer = TestNetworkLayer(usersResponse: usersResponse, postsResponse: postsResponse)
        let sut = FeedViewModel(networkLayer: networkLayer)
        
        // WHEN: loadData() of FeedViewModel is called
        sut.loadData()
        
        // THEN: FeedViewModel's error message must be correct and posts should be empty
        XCTAssertEqual(0, sut.users.count)
        XCTAssertEqual(0, sut.posts.count)
        XCTAssertEqual(RequestError.apiError.localizedDescription, sut.errorMessage)
    }
    
    func test_FedViewModel_should_show_new_post_when_a_new_message_is_posted_on_an_empty_feed(){
        // GIVEN: that we have a network layer that returns empty posts
        let networkLayer: INetworkLayer = InMemoryNetworkLayer()
        let sut = FeedViewModel(networkLayer: networkLayer)
        let postMessage = "This is a test message"
        
        // WHEN: a new tweet is posted
        sut.textToTweet = postMessage
        sut.post()
        
        // THEN: there must be only 1 message.
        XCTAssertEqual(sut.posts.count, 1)
        XCTAssertEqual(sut.posts[0].text, postMessage)
    }
    
    func test_FedViewModel_should_show_new_post_at_the_top_when_a_new_message_is_posted(){
        // GIVEN: that we have a network layer that returns empty posts
        let posts = makePostsData(count: 5)
        let networkLayer: INetworkLayer = InMemoryNetworkLayer(initialData: posts)
        let sut = FeedViewModel(networkLayer: networkLayer)
        let postMessage = "This is a test message"
        
        // WHEN: a new tweet is posted
        sut.textToTweet = postMessage
        sut.post()
        
        // THEN: message count should be incremented 1. And new tweet must be at index 0
        XCTAssertEqual(sut.posts.count, posts.count + 1)
        XCTAssertEqual(sut.posts[0].text, postMessage)
        XCTAssertEqual(sut.posts[0].username, sut.currentUser.username)
    }
    
    func test_FedViewModel_when_switched_to_new_user_new_posts_username_should_be_correct(){
        // GIVEN: that we have a network layer that returns empty posts
        let networkLayer: INetworkLayer = InMemoryNetworkLayer()
        let sut = FeedViewModel(networkLayer: networkLayer)
        let postMessage = "This is a test message"
        let currentUser = User.fromDTO(dto: makeUsersData()[1])
        
        // WHEN: switched to a new user and then posted a tweet
        sut.switchToUser(user: currentUser)
        sut.textToTweet = postMessage
        sut.post()
        
        // THEN: new tweet's username must be equal to currentuser. also there must be only 1 message.
        XCTAssertEqual(sut.posts.count, 1)
        XCTAssertEqual(sut.posts[0].text, postMessage)
        XCTAssertEqual(sut.posts[0].username, currentUser.username)
        XCTAssertEqual(sut.currentUser.username, currentUser.username)
    }
    
    func test_mapping_from_PostDTO_to_Post_model_should_be_correct() {
        // GIVEN: that we have a PostDTO
        let dto = makePostsData(count: 1)[0]
        
        // WHEN: dto is converted to model object
        let sut = Post.fromDTO(dto: dto)
        
        // THEN: we expect fields to be same
        XCTAssertEqual(sut.username, dto.user.username)
        XCTAssertEqual(sut.text, dto.text)
        XCTAssertEqual(sut.name, dto.user.name)
        XCTAssertEqual(sut.image, dto.user.image)
    }
    
    func test_mapping_from_UserDTO_to_User_model_should_be_correct() {
        // GIVEN: that we have a UserDTO
        let dto = makeUsersData()[0]
        
        // WHEN: dto is converted to model object
        let sut = User.fromDTO(dto: dto)
        
        // THEN: we expect fields to be same
        XCTAssertEqual(sut.username, dto.username)
        XCTAssertEqual(sut.image, dto.image)
        XCTAssertEqual(sut.name, dto.name)
        XCTAssertEqual(sut.id, dto.id)
    }
    
}

// MARK: - Test Network Layer

class TestNetworkLayer: INetworkLayer {
    
    private var usersResponse: Result<[UserDTO], RequestError>
    private var postsResponse: Result<[PostDTO], RequestError>
    
    init(usersResponse: Result<[UserDTO], RequestError>,
         postsResponse: Result<[PostDTO], RequestError>){
        self.usersResponse = usersResponse
        self.postsResponse = postsResponse
    }
    
    func getUsers() -> AnyPublisher<[UserDTO], RequestError> {
        return Result<[UserDTO], RequestError>
            .Publisher(usersResponse)
            .eraseToAnyPublisher()
    }
    
    func getAllPosts() -> AnyPublisher<[PostDTO], RequestError> {
        return Result<[PostDTO], RequestError>
            .Publisher(postsResponse)
            .eraseToAnyPublisher()
    }
    
    func post(user: User, post: Post) -> AnyPublisher<Bool, RequestError> {
        return Result<Bool, RequestError>
            .Publisher(.success(true))
            .eraseToAnyPublisher()
    }
}


// MARK: - Dummy data

func makeUsersData() -> [UserDTO] {
    let user0 =  UserDTO(id: "0", username: "user0", name: "Ahmet Kaya", image: "person.crop.circle.fill")
    let user1 =  UserDTO(id: "1", username: "user1", name: "Yılmaz Güney", image: "person.crop.circle.fill")
    let user2 =  UserDTO(id: "2", username: "user2", name: "Kadir İnanır", image: "person.crop.circle.fill")
    return [user0, user1, user2]
}

func makePostsData(count: Int) -> [PostDTO] {
    var data = [PostDTO]()
    for _ in 0..<count {
        let dto = PostDTO(
            id: UUID().uuidString,
            text: "The Shiba Inu token is our foundational currency that allows investors to hold millions, billions, or even trillions, of it in their wallets.",
            user: makeUsersData()[0])
        data.append(dto)
    }
    
    return data
}
