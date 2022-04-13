//
//  TvShow.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import Foundation

struct TvShow {
    let title: String
    let releaseDate: String
    let genre: String
    let region: String
    let overview: String
    let rate: Double
    let starring: String
    let backdropImage: String
    
    init(title: String, releaseDate: String, genre: String, region: String, overview: String, rate: Double, starring: String, backdropImage: String) {
        self.title = title
        self.releaseDate = releaseDate
        self.genre = genre
        self.region = region
        self.overview = overview
        self.rate = rate
        self.starring = starring
        self.backdropImage = backdropImage
    }
}
