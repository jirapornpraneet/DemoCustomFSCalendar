//
//  Int+Extension.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//

import Foundation

extension Int {
    
    /// Return number of nouns (Singular, Plural)
    func of(_ nouns: String) -> String {
        guard self != 1 else { return "\(self) \(nouns)" }
        return "\(self) \(nouns)s"
    }
}
