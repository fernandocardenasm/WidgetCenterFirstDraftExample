//
//  EventTracking.swift
//  WidgetCenterFirstDraftExample
//
//  Created by Fernando Cardenas on 29.03.21.
//

import Foundation

public protocol EventTracking {
    func track(_ eventName: String, dict: [String])
}

class SomeEventTracking: EventTracking {
    func track(_ eventName: String, dict: [String]) {
        print("Track with eventName: \(eventName) and dict: \(dict)")
    }
}
