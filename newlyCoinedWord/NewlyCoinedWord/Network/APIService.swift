//
//  APIService.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/20.
//

import Foundation

import Alamofire

final class APIService {
    
    static func searchEncyc(query: String, display: Int, start: Int, completion: @escaping (SearchEncycResult?, AFError?) -> Void) {
        
        let endpoint = Endpoint.searchEncyc(query: query, display: display, start: start)
        
        let url = endpoint.url
        
        let queue = DispatchQueue.global(qos: .utility)
        
        /* async && concurrent
         alamofire는 기본적으로 async로 동작하고,
         queue는 global 큐를 사용하기로 했기 때문에 concurrent로 동작함
         */
        AF.request(url, method: .get, parameters: endpoint.parameter, encoding: URLEncoding.queryString, headers: APIDefault.header)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: SearchEncycResult.self, queue: queue) { response in
                
                switch response.result {
                case .success(let result):
                    completion(result, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
