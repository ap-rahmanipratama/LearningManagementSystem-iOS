//
//  ListContentCell.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import SwiftUI
import Kingfisher

struct ListContentCell: View {
    
    var contentData: ContentViewData
    
    var body: some View {
        VStack(alignment: .leading) {
            KFImage.url(URL(string: contentData.image))
                .resizing(referenceSize: CGSize(width: UIScreen.main.bounds.width - 8, height: (UIScreen.main.bounds.width - 8)*9/16))
                .aspectRatio(16/9, contentMode: .fit)
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 8, height: ((UIScreen.main.bounds.width - 8)*9/16))
                .clipped()
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
        }.clipShape(.rect(cornerRadius: 12))
            .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        ).frame(width: UIScreen.main.bounds.width - 8)
    }
}

#Preview {
    ListContentCell(contentData: ContentViewData(image: "default_thumbnail", author: "Rahman Pratama", title: "How to make a SwiftUI App", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", duration: "10:00", videoURL: ""))
}
