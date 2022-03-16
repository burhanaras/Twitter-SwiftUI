//
//  Coordinator.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 17.03.2022.
//

import Foundation

final class Coordinator {
    static func feedView() -> FeedView {
        return FeedView(viewModel: FeedViewModel(networkLayer: InMemoryNetworkLayer()))
    }
}
