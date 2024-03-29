//
//  Test_Assessment_IdeaslabUITestsLaunchTests.swift
//  Test Assessment IdeaslabUITests
//
//  Created by USER-MAC-GLIT-007 on 23/01/23.
//

import XCTest

final class Test_Assessment_IdeaslabUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
