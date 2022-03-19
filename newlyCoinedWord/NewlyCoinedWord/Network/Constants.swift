//
//  Constants.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/19.
//

import Foundation

import Alamofire

struct APIClient {
    
    static let clientID = "YqHVy30LyINTaj3pswhO"
    static let clientSecret = "IHKmr8yCIr"
}

struct APIDefault {
    
    static let baseURL = "https://openapi.naver.com"
    
    static let header: HTTPHeaders = [
        "X-Naver-Client-Id": APIClient.clientID,
        "X-Naver-Client-Secret": APIClient.clientSecret
    ]
}
