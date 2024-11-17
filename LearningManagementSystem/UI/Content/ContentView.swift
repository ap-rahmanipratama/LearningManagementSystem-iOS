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
    @State private var isPlaying = false
    @State private var isMuted = false
    @State private var isFullScreen = false
    @State private var isShowingControls = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let player = player {
                    VideoPlayer(player: player)
                        .frame(height: 200)
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.3))
                                .opacity(isShowingControls ? 1 : 0)
                                .overlay{
                                    PlaybackControl()
                                }
                        }
                        .onTapGesture {
                            withAnimation {
                                isShowingControls.toggle()
                            }
                        }
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
        }
    }
    
    @ViewBuilder
    func PlaybackControl() -> some View {
        HStack(spacing: 64) {
            Button {
                
            } label: {
                Image(systemName: "backward.fill")
                    .font(.title2)
                    .tint(.white)
            }.scaleEffect(1.1)
            
            Button {
                if isPlaying {
                    player?.pause()
                } else {
                    player?.play()
                    timeout()
                }
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPlaying.toggle()
                }
            } label: {
                Image(systemName: isPlaying ? "pause.circle" :"play.circle")
                    .font(.title2)
                    .tint(.white)
            }.scaleEffect(3)
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
                    .tint(.white)
            }.scaleEffect(1.1)
        }.opacity(isShowingControls ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: isShowingControls)
        
    }
    
    func timeout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeInOut(duration: 0.2)) {
                if isPlaying {
                    isShowingControls = false
                }
            }
        }
    }
}

#Preview {
    ContentView(contentData: ContentViewData(image: "default_thumbnail", author: "Rahman Pratama", title: "How to make a SwiftUI App", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", duration: "10:00", videoURL: ""))
}
