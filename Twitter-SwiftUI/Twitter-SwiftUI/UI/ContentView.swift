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
            
            Coordinator.feedView()
 
            VStack {
              Spacer()
              HStack {
                Spacer()
                  Coordinator.newTweetButton()
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
