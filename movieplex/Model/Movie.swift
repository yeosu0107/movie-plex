//
//  Movie.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/14.
//

import Foundation

struct Channel : Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [Movie]
}

struct Movie: Codable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
}
