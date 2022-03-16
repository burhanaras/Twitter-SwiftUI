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
            
            FeedView(tweets: DummyData.dummyData(count: 10).map { Post.fromDTO(dto: $0)})
            
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
