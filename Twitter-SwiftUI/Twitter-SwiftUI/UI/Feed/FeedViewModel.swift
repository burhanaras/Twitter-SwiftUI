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
    private var allPosts = [Post]()

    private var cancellables: Set<AnyCancellable> = []
    private var networkLayer: INetworkLayer = InMemoryNetworkLayer()
    
    init(networkLayer: INetworkLayer){
        self.networkLayer = networkLayer
    }
    
    func loadData() {
        
    }
    
    func post(text: String) { }
    
    func filter(userName: String) { }
}
