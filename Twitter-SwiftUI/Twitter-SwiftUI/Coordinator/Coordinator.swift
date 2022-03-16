//
//  Coordinator.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 17.03.2022.
//

import Foundation

final class Coordinator {
    
    private static var networkLayer = InMemoryNetworkLayer()
    private static var viewModel = FeedViewModel(networkLayer: networkLayer)
    
    static func feedView() -> FeedView {
        return FeedView(viewModel: viewModel)
    }
    
    static func newTweetButton() -> NewTweetButton {
        return NewTweetButton(viewModel: viewModel)
    }
}
