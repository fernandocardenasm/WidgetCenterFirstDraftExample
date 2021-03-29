//
//  WidgetCenterSpy.swift
//  WidgetCenterFirstDraftExampleTests
//
//  Created by Fernando Cardenas on 29.03.21.
//

import WidgetCenterFirstDraftExample
import WidgetKit

class WidgetCenterSpy: WidgetCenterProtocol {
    
    typealias ConfigResult = Result<[MyWidgetInfo], Error>
    typealias Completion = (ConfigResult) -> Void
    var configCompletions = [Completion]()
    
    func getCurrentConfigurations(_ completion: @escaping Completion) {
        configCompletions.append(completion)
    }
    
    func complete(withInfos infos: [MyWidgetInfo], at index: Int = 0) {
        configCompletions[index](.success(infos))
    }
    
    func complete(withError error: Error, at index: Int = 0) {
        configCompletions[index](.failure(error))
    }
}

struct MyWidgetInfo: WidgetInfoProtocol {
    let family: WidgetFamily
}
