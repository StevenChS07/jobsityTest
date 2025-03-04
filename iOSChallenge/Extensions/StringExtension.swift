//
//  StringExtension.swift
//  iOSChallenge
//
//  Created by Steven Chaves on 3/3/25.
//

import Foundation

extension String {
    func htmlToString() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        
        do {
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
            
            return attributedString.string
        } catch {
            return self
        }
    }
}
