//
//  ViewController.swift
//  News API with Nav
//
//  Created by Kajol   on 08/05/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articlesList  = [ArticleData]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    func fetchData(){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=718b1cedd1fe4c45b76360392ac61b0d")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else
            {
                print("Error occured while Accessing data with URL")
                return
            }
            var newsFullList: NewsData?
            do{
                newsFullList = try JSONDecoder().decode(NewsData.self, from: data)
            }
            catch{
                print("Error occured while Decoding JSON into swift Structure \(error)")
            }
            self.articlesList = newsFullList!.articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        if articlesList[indexPath.row].author != nil
        {
            cell.authorNameLabel.text = "Author: \(articlesList[indexPath.row].author!)"
        }
        else{
            cell.authorNameLabel.text = "No Author"
        }
        cell.newsTitleLabel.text = articlesList[indexPath.row].title
        if articlesList[indexPath.row].urlToImage != nil
        {
            let url = URL(string: articlesList[indexPath.row].urlToImage!)
            cell.myImageView.downloadImage(from: url!)
            cell.myImageView.contentMode = .scaleToFill
        }
        else{
            cell.myImageView.image = UIImage(named: "empty image")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsContentHome") as! NewsContentHomePageViewController
        vc.newsContent = articlesList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
    extension UIImageView{
        func downloadImage(from url:URL)
        {
            // contentMode = .scaleToFill
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
                (data, response, error) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                      let data = data, error == nil,
                      let image = UIImage(data: data)
                else{
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            })
            dataTask.resume()
        }
    }
    
