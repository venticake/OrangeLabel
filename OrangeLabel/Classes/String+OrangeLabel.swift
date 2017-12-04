//
//  String+OrangeLabel.swift
//  OrangeLabel
//
//  Created by Steve Kim on 09/04/2017.
//  Copyright © 2016 Steve Kim. All rights reserved.
//

import Foundation

extension String {
    func matches(pattern: String) throws -> [NSTextCheckingResult] {
        let regex = try NSRegularExpression(pattern: pattern)
        return regex.matches(in: self, options: .reportCompletion, range: NSRange(0..<utf16.count))
    }
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
