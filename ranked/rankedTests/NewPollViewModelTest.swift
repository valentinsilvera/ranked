//
//  NewPollViewModelTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 10/11/22.
//

import XCTest
@testable import ranked

final class NewPollViewModelTest: XCTestCase {
    
    var viewModel: NewPollViewModel!
    var mockedService: MockPollService!
    var title = "title"
    var creator = "creator"
    var options = ["option1", "option2"]
    var noOptions: [String] = []
    
    override func setUp() {
        mockedService = MockPollService()
        viewModel = .init(service: mockedService)
    }
    
    func testUploadPollWithOptions() {
        viewModel.uploadPoll(withTitle: title, by: creator, withOptions: options)
        XCTAssertTrue(viewModel.didUploadPoll)
    }
    
    func testUploadPollWithoutOptions() {
        viewModel.uploadPoll(withTitle: title, by: creator, withOptions: noOptions)
        XCTAssertTrue(viewModel.didUploadPoll)
    }
}
