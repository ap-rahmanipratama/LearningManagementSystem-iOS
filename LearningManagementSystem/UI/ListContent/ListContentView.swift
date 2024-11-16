//
//  ListContentView.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import SwiftUI

struct ListContentView: View {
    
    let data: [ListContentViewData] = [
        ListContentViewData(
            image: "book1.png",
            author: "Author One",
            title: "SwiftUI Essentials",
            description: "A guide to getting started with SwiftUI and building interfaces for iOS apps, watchOS apps, and more.",
            duration: "2h 30m"
        ),
        ListContentViewData(
            image: "book2.png",
            author: "Author Two",
            title: "Combine in Practice",
            description: "Deep dive into the Combine framework to build robust reactive apps, with practical examples. start with the basics and finish with advanced topics.",
            duration: "3h 15m"
        ),
        ListContentViewData(
            image: "book3.png",
            author: "Author Three",
            title: "Advanced Swift Programming",
            description: "Swift programming concepts.",
            duration: "4h 45m"
        )
    ]
    
    var body: some View {
        NavigationView {
            List(data, id: \.self) { item in
                ListContentCell(contentData: item)
                .listRowSeparator(.hidden)
            }.contentMargins(.horizontal, 0)
            .navigationTitle("Courses")
        }
    }
}

#Preview {
    ListContentView()
}
