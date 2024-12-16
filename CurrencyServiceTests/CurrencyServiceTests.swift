//
//  CurrencyServiceTests.swift
//  CurrencyServiceTests
//
//  Created by An Luu on 16/12/24.
//

import XCTest
@testable import Currency_Converter

/// Unit tests for the CurrencyService class.
class CurrencyServiceTests: XCTestCase {

    var currencyService: CurrencyService!

    override func setUp() {
        super.setUp()
        currencyService = CurrencyService()
    }

    override func tearDown() {
        currencyService = nil
        super.tearDown()
    }

    /// Test that the API key exists and is not empty.
        func testAPIKeyExists() {
            let apiKey = currencyService.getAPIKey()

            XCTAssertNotNil(apiKey, "The API key should not be nil.")
            XCTAssertFalse(apiKey!.isEmpty, "The API key should not be empty.")
        }

    /// Test convertCurrency method handles invalid URL correctly.
    func testConvertCurrencyInvalidURL() {
        let expectation = self.expectation(description: "Invalid URL should return an error.")

        currencyService.convertCurrency(amount: 100.0, fromCurrency: "INVALID", toCurrency: "USD") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error, "An error should be returned for an invalid URL.")
            case .success:
                XCTFail("The conversion should not succeed with an invalid URL.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }


    /// Test convertCurrency handles invalid API response correctly.
    func testConvertCurrencyInvalidResponse() {
        let expectation = self.expectation(description: "Invalid response should return an error.")

        // Simulate a network call that returns invalid JSON.
        currencyService.convertCurrency(amount: 100.0, fromCurrency: "USD", toCurrency: "INVALID") { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error, "An error should be returned for an invalid API response.")
            case .success:
                XCTFail("The conversion should not succeed with an invalid API response.")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
