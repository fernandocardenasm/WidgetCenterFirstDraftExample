//
//  AppDelegate.swift
//  WidgetCenterFirstDraftExample
//
//  Created by Fernando Cardenas on 29.03.21.
//

import UIKit
import WidgetKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let service = WidgetComposer.makeWidgetService()
        service.trackInstalledWidgetInfo()
        
        return true
    }
}

private struct WidgetComposer {
    static func makeWidgetService() -> WidgetCenterService<WidgetCenter> {
        let tracker = SomeEventTracking()
        let service = WidgetCenterService(widgetCenter: WidgetCenter.shared, tracker: tracker)
        return service
    }
}
