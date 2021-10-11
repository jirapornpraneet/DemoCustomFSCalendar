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

extension Date {
    func adding(second: Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: second, to: self)!
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    func difference(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let components = calendar.dateComponents([component], from: date, to: self)
        switch component {
        case .year:
            return components.year ?? 0
        case .month:
            return components.month ?? 0
        case .weekOfMonth:
            return components.weekOfMonth ?? 0
        case .day:
            return components.day ?? 0
        case .hour:
            return components.hour ?? 0
        case .minute:
            return components.minute ?? 0
        case .second:
            return components.second ?? 0
        case .nanosecond:
            return components.nanosecond ?? 0
        default:
            return 0
        }
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
    
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
}
