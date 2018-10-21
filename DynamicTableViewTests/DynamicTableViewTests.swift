//
//  DynamicTableViewTests.swift
//  DynamicTableViewTests
//
//  Created by SHEHAN on 10/21/18.
//  Copyright © 2018 Shehan Gunarathne. All rights reserved.
//

import XCTest
import Alamofire
@testable import DynamicTableView

class DynamicTableViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkRequestToReturnStatusCode200() {
        let url = URL(string: "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data")!
        let promise = expectation(description: "Status code: 200")
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON { response in
                if let statusCode = response.response?.statusCode {
                    if statusCode == 200 {
                        promise.fulfill();
                    } else {
                        XCTFail("Status code: \(statusCode)")
                    }
                }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
