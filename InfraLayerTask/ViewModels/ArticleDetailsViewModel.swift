//
//  ArticleDetailsViewModel.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import Foundation

class ArticleDetailsViewModel {
    
        let article: Article
        
        var articleTitle: String {
            return article.title ?? ""
        }
        
        var articleContent: String {
            return article.content ?? ""
        }
        
        var articleAuthor: String {
            return article.author ?? ""
        }
        
        var articlePublishedAt: Date {
            return article.publishedAt ?? Date()
        }
        
        var articleImageUrl: String? {
            return article.urlToImage ?? ""
        }
        
        var articleUrl: String? {
            return article.url
        }
        
        init(article: Article) {
            self.article = article
        }
}
