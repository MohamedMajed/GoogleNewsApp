//
//  ArticlesViewModel.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import Foundation

class ArticlesViewModel {
    var articleService: ArticlesService
    var articles: [Article] = [] {
        didSet {
            
            self.bindArticlesViewModelToView()
        }
    }
    
    var errorMessage: String = "" {
        didSet {
            
            self.bindViewModelErrorToView()
        }
    }
    
    var bindArticlesViewModelToView: (()->()) = {}
    var bindViewModelErrorToView: (()->()) = {}
    
    init() {
        self.articleService = APIService()
        self.fetchArticlesFromAPI()
    }
    
    init(articleService: ArticlesService = APIService()) {
        self.articleService = articleService
    }

    
    func fetchArticlesFromAPI() {
        articleService.fetchArticles { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articlesResponse):
                    self.articles.append(contentsOf: articlesResponse.articles ?? [])
    
            case .failure(let error):
                let message = error.localizedDescription
                self.errorMessage = message
                print(error.localizedDescription)
            }
        }
    }
}
