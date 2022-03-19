//
//  NewlyCoinedWord.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/19.
//

import Foundation

struct NewlyCoinedWord {
    
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchResult = try? newJSONDecoder().decode(SearchResult.self, from: jsonData)

import Foundation

// MARK: - SearchResult
struct SearchResult: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let itemDescription: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case title, link
        case itemDescription = "description"
        case thumbnail
    }
}

