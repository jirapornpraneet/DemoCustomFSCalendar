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

    // Code here to call data
    func requestData(_ completion: (() -> ())? = nil) {
        
        // callback
        completion?()
    }
}
