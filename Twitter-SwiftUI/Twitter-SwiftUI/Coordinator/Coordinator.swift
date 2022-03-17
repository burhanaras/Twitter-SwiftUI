//
//  Coordinator.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 17.03.2022.
//

import Foundation

final class Coordinator {
    
    private static var networkLayer = InMemoryNetworkLayer(initialData: DummyData.dummyData(count: 3))
    private static var viewModel = FeedViewModel(networkLayer: networkLayer)
    
    static func feedView() -> FeedView {
        return FeedView(viewModel: viewModel)
    }
    
    static func newTweetButton(action: @escaping () -> Void) -> NewTweetButton {
        return NewTweetButton(viewModel: viewModel, action: action)
    }
    
    static func createPostView() -> CreatePostView {
        return CreatePostView(viewModel: viewModel)
    }
}
