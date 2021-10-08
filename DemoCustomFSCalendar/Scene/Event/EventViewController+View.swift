//
//  EventViewController+View.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//  Template file by Nuttawut Wanitchasiri (UnRafe)
//

import UIKit
import FSCalendar

extension EventViewController {
    
    func setupView() {
        setupCalendar()
    }
    
    func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.locale = .th
        calendar.allowsMultipleSelection = true
        calendar.scrollDirection = .vertical
        calendar.today = nil
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.allowsSelection = false
//        calendar.appearance.headerTitleFont = UIFont.Theme.primary_semibold.withSize(20)
//        calendar.appearance.weekdayFont = UIFont.Theme.primary_medium.withSize(14)
//        calendar.appearance.titleFont = UIFont.Theme.primary_medium.withSize(14)
        
        if let date = Calendar.current.date(byAdding: .month, value: 0, to: calendar.currentPage) {
            updateMonth(date)
        }
    }
}
