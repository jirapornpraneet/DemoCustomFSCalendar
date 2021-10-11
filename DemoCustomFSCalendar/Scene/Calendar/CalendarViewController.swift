//
//  CalendarViewController.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 5/10/2564 BE.
//

import UIKit
import FSCalendar

typealias DateRange = (start: Date, end: Date)

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnNextMonth: UIButton!
    @IBOutlet weak var btnPrevMonth: UIButton!
    @IBOutlet weak var lblMessage: UILabel?
    @IBOutlet weak var lblDateConfirm: UILabel?

    var onSelected: ((_ range: DateRange)->())?
    var onSelectedOver: (()->())?
    var range: DateRange?
    var selected = [Date]()
    var isFirstSelected = false
    var isEnabledPast = true
    var currentMonth = Date() {
        didSet {
            updateButton()
        }
    }
    var maxSelected: Int?
    var minimumDate = Date().adding(.month, value: -3)
    var maximumDate = Date().adding(.year, value: 1)
    
    var calendarCurrentMonth = Date() {
        didSet {
            updateButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        updateButton()
        updateCalendar()
        displayTitleMonth(date: Date())
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)

    
    func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = Locale(identifier: "th")
        calendar.allowsMultipleSelection = true
        calendar.scrollDirection = .vertical
        calendar.backgroundColor = .white
        calendar.today = nil
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.rowHeight = 25

        self.calendar.accessibilityIdentifier = "calendar"
        currentMonth = Date()
    }
    
    func updateButton() {
        btnPrevMonth.isEnabled =  self.currentMonth > minimumDate
        btnNextMonth.isEnabled =  self.currentMonth.difference(from: maximumDate, only: .month) < 0
    }
    
    func updateCalendar() {
        if !selected.isEmpty {
            selected.forEach { (date) in
                calendar.select(date)
            }
            displayRangeDates(dates: selected.sorted(by: { $0.compare($1) == .orderedAscending }))
            displayTitleMonth(date: selected[0])
        }
    }
    
    @IBAction func previousMonthAction(_ sender: UIButton) {
        if let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: calendar.currentPage) {
            calendar.setCurrentPage(previousMonth, animated: true)
            displayTitleMonth(date: previousMonth)
            currentMonth = previousMonth
        }
    }
    
    @IBAction func nextMonthAction(_ sender: UIButton) {
        if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: calendar.currentPage) {
            calendar.setCurrentPage(nextMonth, animated: true)
            displayTitleMonth(date: nextMonth)
            currentMonth = nextMonth
        }
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        /// User selected single
        if selected.count == 1 {
            range = DateRange(start: selected[0], end: selected[0])
        } else if selected.count > 1 {
            range = DateRange(start: selected[0], end: selected[1])
        }
        guard let _range = self.range else { return }
        self.onSelected?(_range)
        displayConfirmDate(dates: calendar.selectedDates.sorted(by: { $0.compare($1) == .orderedAscending }))
    }
    
    func displayConfirmDate(dates: [Date]) {
        selected.removeAll()
        for date in dates {
            selected.append(date)
        }
        
        if dates.count == 0 {
            lblMessage?.text = "-"
        } else {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "d MMMM yyyy"
            dateFormatter1.locale = .th
            
            if dates.count == 1  {
                lblDateConfirm?.text = dateFormatter1.string(from: dates[0])
            } else if dates.count == 2  {
                if dates[0].hasSame(.year, as: dates[1]) {
                    dateFormatter1.dateFormat = "d MMMM"
                }
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "d MMMM yyyy"
                dateFormatter2.locale = .th
                lblDateConfirm?.text = dateFormatter1.string(from: dates[0]) + " ถึง " + dateFormatter2.string(from: dates[1])
            }
        }
    }
    
    func displayRangeDates(dates: [Date]) {
        
        selected.removeAll()
        for date in dates {
            selected.append(date)
        }
        
        if dates.count == 0 {
            lblMessage?.text = "-"
        } else {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "d MMMM yyyy"
            dateFormatter1.locale = .th
            
            if dates.count == 1  {
                lblMessage?.text = dateFormatter1.string(from: dates[0])
            } else if dates.count == 2  {
                if dates[0].hasSame(.year, as: dates[1]) {
                    dateFormatter1.dateFormat = "d MMMM"
                }
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "d MMMM yyyy"
                dateFormatter2.locale = .th
                lblMessage?.text = dateFormatter1.string(from: dates[0]) + " ถึง " + dateFormatter2.string(from: dates[1])
            }
        }
    }
    
    func displayTitleMonth(date: Date) {
        let formatterSubTitle = DateFormatter()
        formatterSubTitle.dateFormat = "MMMM yyyy"
        formatterSubTitle.locale = Locale(identifier: "th")
        monthLabel.text = formatterSubTitle.string(from: date)
    }
}


extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func resetCalendar() {
        calendar.selectedDates.forEach({ calendar.deselect($0) })
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return minimumDate
        //return isEnabledPast ? datePast : tomorrow
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return maximumDate
    }
    
    // MARK:- FSCalendarDataSource
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        if let selected = Calendar.current.date(byAdding: .day, value: 1, to: calendar.currentPage) {
            self.currentMonth = selected
            self.monthLabel.text = selected.toString(format: "MMMM")
        }
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return true
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return true
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if isFirstSelected {
            for date in selected {
                calendar.deselect(date)
            }
            isFirstSelected = false
        }
        
        if calendar.selectedDates.count == 3 || maxSelected ?? 0 == 1 {
            self.resetCalendar()
            calendar.select(date)
        }
        
        if let max = maxSelected, max > 1, calendar.selectedDates.count == 2 {
            let more = calendar.selectedDates[0].adding(.day, value: max-1)
            let less = calendar.selectedDates[0].adding(.day, value: 1-max)
            if date > more || date < less {
                calendar.deselect(date)
                calendar.select(date >= more ? more : less)
                self.onSelectedOver?()
            }
        }
    
        self.configureVisibleCells()
        displayRangeDates(dates: calendar.selectedDates.sorted(by: { $0.compare($1) == .orderedAscending }))
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        displayRangeDates(dates: calendar.selectedDates.sorted(by: { $0.compare($1) == .orderedAscending }))
        self.configureVisibleCells()
    }
    
    // MARK: - Private functions
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let diyCell = (cell as! CalendarCell)
        var selectionType = SelectionType.none
        if calendar.selectedDates.count == 2 {
            var first = calendar.selectedDates[0]
            var second = calendar.selectedDates[1]
            if second <= first {
                let temp = first
                first = second
                second = temp
            }
            if date == first {
                selectionType = .leftBorder
            } else if date == second {
                selectionType = .rightBorder
            } else if date >= first && date <= second {
                selectionType = .middle
            }
        } else {
            if calendar.selectedDates.contains(date) {
                if calendar.selectedDates.count == 1 {
                    selectionType = .single
                } else {
                    selectionType = .none
                }
            } else {
                selectionType = .none
            }
        }
        diyCell.selectionColor = #colorLiteral(red: 0.3725490196, green: 0.462745098, blue: 0.8980392157, alpha: 1)
        diyCell.selectionType = selectionType
    }
}
