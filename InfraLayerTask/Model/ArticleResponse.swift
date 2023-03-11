//
//  BaseResponse.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 01/03/2023.
//

import Foundation

struct ArticleResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

struct Source: Codable {
    let name: String?
}
