//
//  ContentListResponse.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

struct ContentListResponse: Codable {
    let title: String
    let presenterName: String
    let description: String
    let thumbnailURL: String
    let videoURL: String
    let videoDuration: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case presenterName = "presenter_name"
        case description
        case thumbnailURL = "thumbnail_url"
        case videoURL = "video_url"
        case videoDuration = "video_duration"
    }
}

