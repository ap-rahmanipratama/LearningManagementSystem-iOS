//
//  ContentView.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import SwiftUI
import AVKit

struct ContentView: BaseView{
    
    var contentData: ContentViewData

    @State private var player: AVPlayer?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(height: 200)
                }
                VStack(alignment: .leading) {
                    Text(contentData.author).padding(.top, 4)
                    
                    Text(contentData.title).bold()
                    
                    Text(contentData.description)
                        .lineLimit(2)
                        .padding(.top, 2)
                    
                    Text(contentData.duration).bold()
                        .padding(.top, 8)
                        .padding(.bottom, 12)
                }.padding(.horizontal, 16)
            }
        }.onAppear {
            self.initObserver()
            self.loadData()
        }
    }
    
    func loadData() {
        if !contentData.videoURL.isEmpty {
            guard let url = URL(string: contentData.videoURL) else { return }
            player = AVPlayer(url: url)
            player?.play()
        }
    }
}

#Preview {
    ContentView(contentData: ContentViewData(image: "default_thumbnail", author: "Rahman Pratama", title: "How to make a SwiftUI App", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", duration: "10:00", videoURL: ""))
}