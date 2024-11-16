//
//  VideoPlayer.swift
//  LearningManagementSystem
//
//  Created by Rahman on 17/11/24.
//

import SwiftUI
import AVKit

struct VideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
}
