//
//  WidgetCenterProtocol.swift
//  WidgetCenterFirstDraftExample
//
//  Created by Fernando Cardenas on 29.03.21.
//

import WidgetKit

@available(iOS 14.0, *)
public protocol WidgetCenterProtocol {
    associatedtype MyWidgetInfo: WidgetInfoProtocol

    func getCurrentConfigurations(_ completion: @escaping (Result<[MyWidgetInfo], Error>) -> Void)
}

@available(iOS 14.0, *)
extension WidgetCenter: WidgetCenterProtocol {}
