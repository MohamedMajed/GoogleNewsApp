//
//  ArticlesTableViewCell.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 01/03/2023.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readLaterButton: UIButton!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
                UIView.animate(withDuration: 0.2, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                }, completion: { finished in
                    UIView.animate(withDuration: 0.2) {
                        self.transform = .identity
                    }
            })
        }
    }
    // MARK: - Configure Table view cell
    
    func configureCell(authorName: String, title: String, content: String, publishedDate: Date?) {
        
        authorNameLabel.text = authorName
        titleLabel.text = title
        contentLabel.text = content
        
        let dateComponents = Calendar.current.dateComponents([.hour, .day, .weekOfMonth, .month], from: .now, to: publishedDate ?? .now)
        let formatter = RelativeDateTimeFormatter()
        let timeInterval = formatter.localizedString(from: dateComponents)
        timeIntervalLabel.text = timeInterval
    }
}
