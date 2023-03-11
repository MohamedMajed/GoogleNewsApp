//
//  ArticlesTableViewController.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    private let articleViewModel = ArticlesViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()

        startActivityIndicator()
        configureTableView()
        subscribeToViewModelEvents()
    }
    
    private func subscribeToViewModelEvents() {
        
        articleViewModel.bindArticlesViewModelToView = { [weak self] in
            self?.onSuccessUpdateView()
        }
        
        articleViewModel.bindViewModelErrorToView = { [weak self] in
            self?.showErrorAlert()
        }
    }
    
    // MARK: - Update Table view
    
    private func onSuccessUpdateView() {
        
        tableView.reloadData()
        stopActivityIndicator()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error 404", message: articleViewModel.errorMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default) {
            (UIAlertAction) in
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func startActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor.darkGray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Configure Table view
    
    func configureTableView() {
        tableView.register(cellType: ArticleTableViewCell.self)
        tableView.backgroundView?.layer.opacity = 0.7
        tableView.separatorStyle = .singleLine
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return articleViewModel.articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: ArticleTableViewCell.self, for: indexPath)
        
        cell.selectionStyle = .none
        let article = articleViewModel.articles[indexPath.row]
        
        cell.configureCell(authorName: article.author ?? "", title: article.title ?? "", content: article.content ?? "", publishedDate: article.publishedAt)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetailsVC = ArticleDetailsVC.instance()
        articleDetailsVC.sheetHeight = view.bounds.height * 0.7

        let articleDetailsViewModel = ArticleDetailsViewModel(article: articleViewModel.articles[indexPath.row])
            articleDetailsVC.articleDetailsViewModel = articleDetailsViewModel
        
        presentSheetController(viewToPresent: articleDetailsVC,topCornersRadius: 20 ,height: articleDetailsVC.sheetHeight)
        
    }
}
