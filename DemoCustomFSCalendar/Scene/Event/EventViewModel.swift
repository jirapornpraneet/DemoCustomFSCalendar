//
//  EventViewModel.swift
//  DemoCustomFSCalendar
//
//  Created by iOS Dev on 8/10/2564 BE.
//  Copyright © 2564 BE ___ORGANIZATIONNAME___. All rights reserved.
//  Template file by Nuttawut Wanitchasiri (UnRafe)
//

import UIKit

class EventViewModel {
    
    var eventsInfo = [EventInfo]()
    
    struct Sender {
        var id: Int
    }
    
    /// Variable Sender
    var sender: Sender?
    
    // Code here to create your view model
}

extension EventViewModel {

    func fetchMenu(_ completion: (() -> ())? = nil) {
        
        eventsInfo.append(EventInfo(dateStart: "2021-10-04T00:00:00+07:00", dateEnd: "2021-10-04T23:59:59+07:00", typeId: 2, title: ""))
        
        eventsInfo.append(EventInfo(dateStart: "2021-10-11T00:00:00+07:00", dateEnd: "2021-05-14T23:59:59+07:00", typeId: 1, title: ""))
        
        eventsInfo.append(EventInfo(dateStart: "2021-10-30T00:00:00+07:00", dateEnd: "2021-05-31T23:59:59+07:00", typeId: 3, title: ""))
        
        
        completion?()
    }
}
