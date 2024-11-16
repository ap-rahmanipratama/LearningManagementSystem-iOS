//
//  Package.swift
//  LearningManagementSystem
//
//  Created by Rahman on 16/11/24.
//

import PackageDescription


let package = Package(
  name: "LearningManagementSystem",
  dependencies: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
  ],
  targets: [
    .target(name: "LearningManagementSystem", dependencies: ["RxSwift", .product(name: "RxCocoa", package: "RxSwift")]),
  ]
)
