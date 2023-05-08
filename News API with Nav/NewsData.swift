//
//  NewsData.swift
//  News API with Nav
//
//  Created by Kajol   on 08/05/23.
//

import Foundation
struct NewsData: Codable
{
    let status: String
    let articles: [ArticleData]
    
}
