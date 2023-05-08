//
//  ArticleData.swift
//  News API with Nav
//
//  Created by Kajol   on 08/05/23.
//

import Foundation
struct ArticleData: Codable{
    let author: String?
    let title: String
    let urlToImage: String?
    let content: String?
}
