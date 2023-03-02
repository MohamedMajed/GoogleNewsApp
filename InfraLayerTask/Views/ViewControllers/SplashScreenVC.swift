//
//  SplashScreenVC.swift
//  InfraLayerTask
//
//  Created by Mohamed Maged on 02/03/2023.
//

import UIKit

class SplashScreenVC: UIViewController {

    @IBOutlet weak var splashImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    // MARK: - Navigation

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }
            let articleVC = ArticlesTableViewController()
            self.present(articleVC, animated: true, completion: nil)
        }
    }
}
