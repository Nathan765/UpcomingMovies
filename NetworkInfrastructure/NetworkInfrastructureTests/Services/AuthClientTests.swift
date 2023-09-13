//
//  AuthClientTests.swift
//  NetworkInfrastructure-Unit-NetworkInfrastructureTests
//
//  Created by Alonso on 12/09/23.
//

import XCTest
@testable import NetworkInfrastructure

final class AuthClientTests: XCTestCase {

    private var urlSession: MockURLSession!
    private var authClient: AuthClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        urlSession = MockURLSession()
        authClient = AuthClient(session: urlSession)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        authClient = nil
        try super.tearDownWithError()
    }

    func testGetRequestTokenSuccess() throws {
        // Arrange
        let data = try JSONEncoder().encode(RequestTokenResult(success: true, token: ""))
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get request token success")
        // Act
        authClient.getRequestToken(with: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get request token error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetRequestTokenError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get request token error")
        // Act
        authClient.getRequestToken(with: "") { result in
            switch result {
            case .success:
                XCTFail("Get request token success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccessTokenSuccess() throws {
        // Arrange
        let data = try JSONEncoder().encode(AccessToken(token: "", accountId: ""))
        guard let url = URL(string: "www.google.com") else {
            XCTFail("Invalid URL")
            return
        }
        urlSession.dataTaskWithRequestCompletionHandler = (data, HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        let expectation = XCTestExpectation(description: "Get access token success")
        // Act
        authClient.getAccessToken(with: "", requestToken: "") { result in
            switch result {
            case .success:
                break
            case .failure:
                XCTFail("Get access token error")
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAccessTokenError() throws {
        // Arrange
        urlSession.dataTaskWithRequestCompletionHandler = (nil, nil, nil)
        let expectation = XCTestExpectation(description: "Get access token error")
        // Act
        authClient.getAccessToken(with: "", requestToken: "") { result in
            switch result {
            case .success:
                XCTFail("Get access token success")
            case .failure:
                break
            }
            expectation.fulfill()
        }
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}
