//
//  WidgetCenterService.swift
//  WidgetCenterFirstDraftExample
//
//  Created by Fernando Cardenas on 29.03.21.
//

import WidgetKit

public final class WidgetCenterService<MyWidgetCenter: WidgetCenterProtocol> {
    
    // MARK: - Properties
    
    private let widgetCenter: MyWidgetCenter
    private let tracker: EventTracking
    
    // MARK: - Initiliazers
    
    public init(widgetCenter: MyWidgetCenter, tracker: EventTracking) {
        self.widgetCenter = widgetCenter
        self.tracker = tracker
    }
    
    // MARK: - Actions
    
    public func trackInstalledWidgetInfo() {
        widgetCenter.getCurrentConfigurations { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(info):
                let families = info.map { $0.family }
                let mappedFamilies = self.map(families)
                self.tracker.track("widgetEvent", dict: mappedFamilies)
            case .failure:
                break
            }
        }
    }
    
    private func map(_ families: [WidgetFamily]) -> [String] {
        families.compactMap { family in
            switch family {
            case .systemSmall: return "small"
            case .systemMedium: return "medium"
            case .systemLarge: return "large"
            @unknown default: return nil
            }
        }
    }
}
