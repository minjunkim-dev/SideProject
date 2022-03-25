//
//  NetworkManager.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/22.
//

import Foundation
import Network

final class NetworkManager {
    
    private static let monitor = NWPathMonitor()
    
    static func startMonitor() {
        monitor.start(queue: .global(qos: .background))
        
        monitor.pathUpdateHandler = { path in
            
            let status = checkMonitor()
            switch status {
            case .satisfied: print("connected")
                
                /* 신조어 리스트가 비어있고 네트워크가 연결되었다면, 신조어 리스트를 가져오라고 노티 발송 */
                if UserDefaults.wordList.isEmpty {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "fetchWordList"), object: nil)
                }
                
            case .requiresConnection, .unsatisfied: print("not connected")
            @unknown default: print("unkown default")
            }
            
            if path.usesInterfaceType(.wifi) {
                print("wifi")
            } else if path.usesInterfaceType(.cellular) {
                print("cellular")
            } else if path.usesInterfaceType(.wiredEthernet) {
                print("wiredEthernet")
            } // ...
        }
    }
    
    static func checkMonitor() -> NWPath.Status {
        return monitor.currentPath.status
    }
    
    static func stopMonitor() {
        monitor.cancel()
    }
}
