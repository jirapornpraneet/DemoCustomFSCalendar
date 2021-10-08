//
//  EventViewController.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//  Template file by Nuttawut Wanitchasiri (UnRafe)
//

import UIKit
import FSCalendar

class EventViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var btnPrvs: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnMonth: UIButton!

    var viewModel = EventViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func updateMonth(_ date: Date) {
        btnMonth.setTitle(date.toString(format: "MMMM yyyy"),for: .normal)
    }
}

// MARK:- FSCalendarDataSource

extension EventViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // MARK:- FSCalendarDataSource
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        if let selected = Calendar.current.date(byAdding: .day, value: 1, to: calendar.currentPage) {
//            self.didSelectedDate(selected)
            self.updateMonth(selected)
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        var textColor: UIColor?
        let _ = viewModel.eventsInfo.map { (event) -> String in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            let startDate = formatter.string(from: event.dateStart!)
            let endDate = formatter.string(from: event.dateEnd!)
            let positionDate = formatter.string(from: date)
            if positionDate == startDate || positionDate == endDate {
                if event.leaveType == .Unspecified {
                    textColor = #colorLiteral(red: 0.3725490196, green: 0.462745098, blue: 0.8980392157, alpha: 1)
                }
            }
            return ""
        }
        return textColor
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let cell = (cell as! CalendarCell)
        if position == .current {
            var eventColor = UIColor.white
            var selectionType = SelectionType.none
    
            let _ = viewModel.eventsInfo.map { (event) -> String in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                formatter.locale = .standard
                let startDate = formatter.string(from: event.dateStart!)
                let endDate = formatter.string(from: event.dateEnd!)
                let positionDate = formatter.string(from: date)
                if positionDate == startDate {
                    if startDate == endDate {
                        eventColor = event.color
                        selectionType = .single
                    } else {
                        eventColor = event.color
                        selectionType = .leftBorder
                    }
                } else if positionDate == endDate {
                    if startDate == endDate {
                        eventColor = event.color
                        selectionType = .single
                    } else {
                        eventColor = event.color
                        selectionType = .rightBorder
                    }
                } else if positionDate >= startDate && positionDate <= endDate {
                    selectionType = .middle
                    eventColor = event.color
                }
                
                return positionDate
            }
            cell.selectionColor = eventColor
            cell.selectionType = selectionType
        } else {
            cell.roundedLayer.isHidden = true
            cell.selectionLayer.isHidden = true
            cell.selectionColor = .white
            cell.selectionType = .none
        }
    }
}
