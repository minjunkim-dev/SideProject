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
