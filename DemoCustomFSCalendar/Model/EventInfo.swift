//
//  EventInfo.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//

import Foundation
import UIKit

class EventInfo: NSObject {
    
    var dateStart: Date?
    var dateEnd: Date?
    var typeId: Int?
    var color: UIColor {
        guard leaveType != .Unspecified else { return leaveType.color }
        return UIColor(named: "#F46A6A")!
    }

    var leaveType: LeaveType {
        set {
            typeId = newValue.rawValue
        }
        get {
            return LeaveType.toCase(typeId ?? 0)
        }
    }
    
    init(dateStart: String,dateEnd: String, typeId: Int, title: String) {
        super.init()
        self.dateStart = dateStart.toDate()
        self.dateEnd = dateEnd.toDate()
        self.typeId = typeId
    }
}

enum LeaveType: Int, CaseIterable {
    
    // Late is null from server
    case Unspecified = 0, Sick, Vacation, Personal, Other
    case Late = 999
    
    static var list: [LeaveType] { return LeaveType.allCases.filter({ $0 != .Unspecified }) }
    
    static func toCase(_ value: Int) -> LeaveType {
        
        /// Condition check `value` is in 4...998 (Force to leave other)
        let caseId = value > LeaveType.Other.rawValue && value < LeaveType.Late.rawValue ? LeaveType.Other.rawValue : value
        if let type = LeaveType(rawValue: caseId) {
            return type
        }
        return .Unspecified
    }
    
    static var titleList: [LeaveType: String] { return [
        .Unspecified: "N/A",
        .Sick       : "ลาป่วย",
        .Vacation   : "ลาพักร้อน",
        .Personal   : "ลากิจ",
        .Other      : "ลาอื่นๆ",
        .Late       : "สาย"
    ]}
    
    static var colorList: [LeaveType: UIColor] { return [
        .Unspecified: #colorLiteral(red: 0.8793845773, green: 0.902122438, blue: 0.9972243905, alpha: 1),
        .Sick       : #colorLiteral(red: 0.9568627451, green: 0.4156862745, blue: 0.4156862745, alpha: 1),
        .Vacation   : #colorLiteral(red: 0.1450980392, green: 0.4549019608, blue: 0.662745098, alpha: 1),
        .Personal   : #colorLiteral(red: 0.2784313725, green: 0.7921568627, blue: 0.7568627451, alpha: 1),
        .Other      : #colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1),
        .Late       : #colorLiteral(red: 0.9803921569, green: 0.537254902, blue: 0.2352941176, alpha: 1),
    ]}
    
    static var oppositeColorList: [LeaveType: UIImage] { return [
        .Unspecified: #imageLiteral(resourceName: "img_leave_sickneeded"),
        .Sick       : #imageLiteral(resourceName: "img_leave_sick"),
        .Vacation   : #imageLiteral(resourceName: "img_leave_vacation"),
        .Personal   : #imageLiteral(resourceName: "img_leave_personal"),
        .Other      : #imageLiteral(resourceName: "img_leave_other"),
        .Late       : #imageLiteral(resourceName: "img_leave_late"),
    ]}
}

extension LeaveType {
    
    var title: String {
        return LeaveType.titleList[self]!
    }
    
    var color: UIColor {
        return LeaveType.colorList[self]!
    }
    
    var icon: UIImage {
        return LeaveType.oppositeColorList[self]!
    }
}

