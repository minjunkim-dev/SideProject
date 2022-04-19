//
//  String+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/19.
//

extension String {
    
    func convertToResourceName() -> String {
        
        return self
            .lowercased()
            .replacingOccurrences(of: "'", with: "")
            .replacingOccurrences(of: ":", with: "")
            .components(separatedBy: ["&"])
            .map {
                $0.trimmingCharacters(in: [" "])
            }
            .joined(separator: " ")
            .replacingOccurrences(of: "-", with: "_")
            .replacingOccurrences(of: " ", with: "_")
    }
}
