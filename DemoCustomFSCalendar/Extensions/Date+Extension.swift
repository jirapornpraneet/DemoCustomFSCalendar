//
//  Date+Extension.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//

import Foundation

extension Date {
    
    /// Date to string with normal format.
    func toString(format: String = Constant.Formatt.Date.regular, style: DateFormatter.Style = .short, local: Locale = .th, calender: Calendar = .buddhist) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.dateFormat = format
        formatter.calendar = calender
        formatter.locale = local
        return formatter.string(from: self)
    }
}

extension Locale {
    
    public static var standard: Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
    public static var th: Locale {
        return Locale(identifier: "th")
    }
    
    public static var en: Locale {
        return Locale(identifier: "en")
    }
}

extension Calendar {
    
    public static var buddhist: Calendar {
        return Calendar(identifier: .buddhist)
    }
    
    public static var gregorian: Calendar {
        return Calendar(identifier: .gregorian)
    }
}
