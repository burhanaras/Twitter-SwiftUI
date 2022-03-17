//
//  ContentView.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showComposeTweetSheet = false
    
    var body: some View {
        ZStack {
            
            Coordinator.feedView()
 
            VStack {
              Spacer()
              HStack {
                Spacer()
                  Coordinator.newTweetButton(action: {
                      showComposeTweetSheet = true
                      //viewModel.post(text: "Bismillah")
                  })
                  .padding(.bottom, 24)
                  .padding(.trailing)
              }
            }
            
        }
        .sheet(isPresented: $showComposeTweetSheet) {
            
        } content: {
            Coordinator.createPostView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
