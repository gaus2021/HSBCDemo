//
//  MockJokesRepositoryTests.swift
//  HSBCDemoTests
//
//  Created by Ghous Ansari on 31/01/24.
//

import XCTest
@testable import HSBCDemo

final class JokesViewModelTests: XCTestCase {
    
    var viewModel: JokesViewModel!
    var mockService: MockJokesRepository!
    
    override func setUpWithError() throws {
        mockService = MockJokesRepository()
        viewModel = JokesViewModel(repository: mockService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockService = nil
    }
    
    func testFetchItemsSuccess() {
        let mockRepository = MockJokesRepository()
        let viewModel = JokesViewModel(repository: mockRepository)
        
        let expectation = self.expectation(description: "Successful Fetch of Jokes")
        
        viewModel.items = { items in
            XCTAssertEqual(items.count, 1)
            XCTAssertEqual(items.first?.joke, "Sample Joke")
            expectation.fulfill()
        }
        
        viewModel.onErrorHandling = { error in
            XCTFail("Expected success but got \(error)")
        }
        
        viewModel.fetchItems()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchItemsFailure() {
        let mockRepository = MockJokesRepository()
        mockRepository.shouldReturnError = true
        
        let viewModel = JokesViewModel(repository: mockRepository)
        
        let expectation = self.expectation(description: "Failed Fetch of Jokes")
        
        viewModel.items = { items in
            XCTFail("Expected failure but got success")
        }
        
        viewModel.onErrorHandling = { error in
            XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. ( error 0.)")
            expectation.fulfill()
        }
        
        viewModel.fetchItems()
        waitForExpectations(timeout: 5, handler: nil)
    }
}
