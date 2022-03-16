//
//  FeedView.swift
//  Twitter-SwiftUI
//
//  Created by Burhan Aras on 16.03.2022.
//

import SwiftUI

struct FeedView: View {
    let tweets: [Post]
    let viewModel: FeedViewModel = FeedViewModel(networkLayer: InMemoryNetworkLayer())
    
    var body: some View {
        NavigationView {
            List(tweets) { tweet in
                TweetView(tweet: tweet)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Twitter", displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Menu(content: {
                        
                        ForEach(viewModel.users) { user in
                            Button(action: {
                                viewModel.filter(userName: user.username)
                            }) {
                                HStack {
                                    Image(systemName: user.image)
                                        .foregroundColor(.twitterBlue)
                                    Text("\(user.name)").font(.footnote)
                                }
                            }
                        }
                        
                        
                        
                    }, label: {
                        Button(action: {}) {
                            VStack {
                                Image(systemName: viewModel.currentUser.image)
                                    .foregroundColor(.twitterBlue)
                                Text("\(viewModel.currentUser.name)")
                                    .font(.system(size: 9))
                            }
                        }
                    })
            )
        }
    }
}


struct TweetView: View {
    let tweet: Post
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: tweet.image)
                .font(.system(size: 55))
                .padding(.top, 5)
                .padding(.trailing, 5)
                .foregroundColor(.twitterBlue)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(tweet.name)
                        .bold()
                        .lineLimit(1)
                    Text("@\(tweet.username)")
                        .lineLimit(1)
                        .truncationMode(.middle)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
                
                Text(tweet.text)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                
                TweetActionsView()
                    .foregroundColor(.gray)
                    .padding([.bottom, .top], 10)
                    .padding(.trailing, 30)
            }
        }
    }
}

struct TweetActionsView: View {
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "message")
            }
            Text("12")
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "arrow.2.squarepath")
            }
            Text("4")
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "heart")
            }
            Text("8")
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}

struct NewTweetButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "pencil")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.twitterBlue)
        .mask(Circle())
        .shadow(radius: 5)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(tweets: DummyData.dummyData(count: 10).map { Post.fromDTO(dto: $0)})
        TweetView(tweet: Post.fromDTO(dto: DummyData.dummyData(count: 1)[0]))
    }
}
