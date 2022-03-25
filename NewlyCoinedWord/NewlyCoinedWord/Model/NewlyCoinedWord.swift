//
//  NewlyCoinedWord.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/19.
//

import Foundation

enum SearchError: Error {
    case isEmptyWordList
    case notExistWordInList
    
    var description: String {
        switch self {
        case .isEmptyWordList:
            return "requiredNetwork".localized()
        case .notExistWordInList:
            return "isNotNeologism".localized()
        }
    }
}

struct NewlyCoinedWord: Codable {
    
    var title: String
    var description: String
}

extension NewlyCoinedWord: Equatable {
    
    static func == (lhs: NewlyCoinedWord, rhs: NewlyCoinedWord) -> Bool {
        return (lhs.title == rhs.title) && (lhs.description == rhs.description)
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchResult = try? newJSONDecoder().decode(SearchResult.self, from: jsonData)

// MARK: - SearchEncycResult
struct SearchEncycResult: Codable {
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

