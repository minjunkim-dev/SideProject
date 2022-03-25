//
//  Endpoint.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/19.
//

import Foundation

import Alamofire

enum Endpoint {
    case searchEncyc(query: String, display: Int, start: Int)
}

extension Endpoint {
    
    var url: URL {
        switch self {
        case .searchEncyc(_, _, _):
            return .makeEndpoint(endpoint: "/v1/search/encyc.json")
        }
    }

    var parameter: Parameters {
        switch self {
        case .searchEncyc(let query, let display, let start):
            return [
                "query": query,
                "display": display,
                "start": start,
                "sort": "sim"
            ]
        }
    }
}

extension URL {

    static func makeEndpoint(endpoint: String) -> URL {
        return URL(string: APIDefault.baseURL + endpoint)!
    }
}
