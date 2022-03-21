//
//  String+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/21.
//

import Foundation

extension String {
    
    var withoutHTMLTags: String {
        
        guard let data = self.data(using: .utf8) else { return self }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return self }
        
        return attributedString.string
    }
}
