//
//  HomeScreenViewModelTest.swift
//  rankedTests
//
//  Created by Valentin Silvera on 8/11/22.
//

import XCTest
@testable import ranked

final class HomeScreenViewModelTest: XCTestCase {
    
    var viewModel: HomeScreenViewModel!
    var mockedService: MockPollService!

    override func setUp() {
        mockedService = MockPollService()
        viewModel.init()
    }
    
    func testFetchPolls() {
        viewModel.fetchPolls()
        XCTAssertTrue(viewModel.polls == [mockedPoll, mockedPoll])
    }
}
