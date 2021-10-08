//
//  String+Extension.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//

import Foundation
import UIKit

extension String {
    
    /// Convert string to date with format.
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss", local: Locale = .current, calendar: Calendar = .current, timezone: TimeZone = .current) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timezone
        dateFormatter.locale = local
        dateFormatter.calendar = calendar
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
