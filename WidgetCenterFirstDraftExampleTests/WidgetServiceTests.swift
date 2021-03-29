//
//  WidgetServiceTests.swift
//  WidgetCenterFirstDraftExampleTests
//
//  Created by Fernando Cardenas on 29.03.21.
//

import WidgetCenterFirstDraftExample
import WidgetKit
import XCTest

class WidgetServiceTests: XCTestCase {
    
    func test_init_doesTrackInstalledWidgets() {
        let (_, tracking, _) = makeSUT()
        
        XCTAssertTrue(tracking.events.isEmpty)
    }
    
    func test_trackInstalledWidgets_onWidgetsNonEmpty() {
        let (sut, tracker, center) = makeSUT()
        
        sut.trackInstalledWidgetInfo()
        
        let infos: [MyWidgetInfo] = [.init(family: .systemSmall),
                                     .init(family: .systemMedium),
                                     .init(family: .systemLarge)]
        center.complete(withInfos: infos)
        
        XCTAssertEqual(tracker.events,
                       [EventTrackingSpy.Event(
                            name: "widgetEvent",
                            dict: ["small",
                                   "medium",
                                   "large"]
                       )]
        )
    }
    
    func test_trackInstalledWidgetsTwice_tracksTwice() {
        let (sut, tracker, center) = makeSUT()

        sut.trackInstalledWidgetInfo()
        sut.trackInstalledWidgetInfo()

        let infos: [MyWidgetInfo] = [.init(family: .systemSmall),
                                     .init(family: .systemMedium),
                                     .init(family: .systemLarge)]
        center.complete(withInfos: infos, at: 0)
        center.complete(withInfos: infos, at: 1)

        let eventName = "widgetEvent"
        let dict = ["small",
                    "medium",
                    "large"]
        XCTAssertEqual(tracker.events,
                       [EventTrackingSpy.Event(
                            name: eventName,
                            dict: dict
                       ),
                       EventTrackingSpy.Event(
                            name: eventName,
                            dict: dict
                       )]
        )
    }

    func test_trackInstalledWidgets_onWidgetsEmpty() {
        let (sut, tracker, center) = makeSUT()

        sut.trackInstalledWidgetInfo()

        let infos: [MyWidgetInfo] = []
        center.complete(withInfos: infos)

        XCTAssertEqual(tracker.events,
                       [EventTrackingSpy.Event(
                            name: "widgetEvent",
                            dict: []
                       )]
        )
    }

    func test_trackInstalledWidgets_doesNotTrack_onError() {
        let (sut, tracker, center) = makeSUT()

        sut.trackInstalledWidgetInfo()

        center.complete(withError: anyNSError())

        XCTAssertTrue(tracker.events.isEmpty)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (WidgetCenterService<WidgetCenterSpy>, EventTrackingSpy, WidgetCenterSpy) {
        let tracker = EventTrackingSpy()
        let center = WidgetCenterSpy()
        let sut = WidgetCenterService(widgetCenter: center, tracker: tracker)
        
        trackForMemoryLeaks(tracker, file: file, line: line)
        trackForMemoryLeaks(center, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, tracker, center)
    }
    
    private func anyNSError() -> NSError {
        NSError(domain: "any", code: 200)
    }
    
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential Memory leak.", file: file, line: line)
        }
    }
}
