//
//  ArticleDetailsVC.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import UIKit
import Kingfisher

class ArticleDetailsVC: BottomSheetVC {
    
    // MARK: - IBOutlets


    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articlePublishDateLabel: UILabel!
    @IBOutlet weak var articleContentLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    var articleDetailsViewModel: ArticleDetailsViewModel!

    var articleDetails: Article?
    static func instance()-> ArticleDetailsVC {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ArticleDetailsVC") as! ArticleDetailsVC
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Private Methods
    
    func configureView() {
            guard let articleDetailsViewModel = articleDetailsViewModel else {
                return
            }
                
        if let urlString = articleDetailsViewModel.articleImageUrl, let url = URL(string: urlString) {
            articleImageView.kf.setImage(with: url)
        }
        articleTitleLabel.text = articleDetailsViewModel.article.title
        articleAuthorLabel.text = articleDetailsViewModel.article.author
        
        let dateComponents = Calendar.current.dateComponents([.hour, .day, .weekOfMonth, .month], from: .now, to: articleDetailsViewModel.articlePublishedAt ?? .now)
        let formatter = RelativeDateTimeFormatter()
        let timeInterval = formatter.localizedString(from: dateComponents)
        
        articlePublishDateLabel.text = timeInterval
        articleContentLabel.text = articleDetailsViewModel.article.content
        }
}
