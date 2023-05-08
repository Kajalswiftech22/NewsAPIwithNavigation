//
//  NewsContentHomePageViewController.swift
//  News API with Nav
//
//  Created by Kajol   on 08/05/23.
//

import UIKit

class NewsContentHomePageViewController: UIViewController {
    
    @IBOutlet weak var headlineTitleLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var myIconImageView: UIImageView!
    var newsContent:ArticleData = ArticleData(author: "", title: "", urlToImage: "", content: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        headlineTitleLabel.text = newsContent.title
        if newsContent.urlToImage != nil
        {
            let url = URL(string: newsContent.urlToImage!)
            myIconImageView.downloadImage(from: url!)
            myIconImageView.contentMode = .scaleToFill
        }
        else{
            myIconImageView.image = UIImage(named: "")
        }
        newsContentLabel.text = newsContent.content
        
    }

}
