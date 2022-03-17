//
//  CreatePostView.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FeedViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }

                Spacer()
                
                Button {
                    viewModel.post()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Post It!")
                        .padding(8)
                        .background(Color.twitterBlue.opacity(viewModel.textToTweet.isEmpty ? 0.6 : 1))
                        .foregroundColor(.white)
                        .cornerRadius(36)
                }
                .disabled(viewModel.textToTweet.isEmpty)
            }
            
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(.twitterBlue)
                    .font(.title)
                TextField("What's happening?", text: $viewModel.textToTweet)
            }


            Spacer()
        }
        .padding()
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(viewModel: FeedViewModel(networkLayer: DummyNetworkLayer()))
    }
}
