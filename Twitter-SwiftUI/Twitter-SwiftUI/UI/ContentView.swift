//
//  ContentView.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            FeedView(viewModel: FeedViewModel(networkLayer: InMemoryNetworkLayer()))
 
            VStack {
              Spacer()
              HStack {
                Spacer()
                NewTweetButton()
                  .padding(.bottom, 24)
                  .padding(.trailing)
              }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
