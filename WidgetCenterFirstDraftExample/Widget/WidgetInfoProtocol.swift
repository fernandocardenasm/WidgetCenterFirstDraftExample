//
//  WidgetInfoProtocol.swift
//  WidgetCenterFirstDraftExample
//
//  Created by Fernando Cardenas on 29.03.21.
//

import WidgetKit

@available(iOS 14.0, *)
public protocol WidgetInfoProtocol {
    var family: WidgetFamily { get }
}

@available(iOS 14.0, *)
extension WidgetInfo: WidgetInfoProtocol {}
