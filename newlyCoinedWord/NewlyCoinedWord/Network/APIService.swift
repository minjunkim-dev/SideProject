//
//  APIService.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/20.
//

import Foundation

import Alamofire

final class APIService {
    
    static func searchEncyc(query: String, display: Int, start: Int, completion: @escaping (SearchResult?, AFError?) -> Void) {
        
        let endpoint = Endpoint.searchEncyc(query: query, display: display, start: start)
        
        let url = endpoint.url
        
        AF.request(url, method: .get, parameters: endpoint.parameter, encoding: URLEncoding.queryString, headers: APIDefault.header)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: SearchResult.self) { response in
                
                switch response.result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
