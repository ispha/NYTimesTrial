//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by ispha on 12/2/20.
//  Copyright © 2020 ispha. All rights reserved.
//

import XCTest
@testable import OdiggoTask
class NYTimesTests: XCTestCase {
    
        var articlesVC : ArticlesViewController!
        override func setUp() {
               super.setUp()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let controller = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController") as! ArticlesViewController
            articlesVC = controller
        }
        override func setUpWithError() throws {
            
          
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }
        func testEmptyState()
        {
           
            articlesVC.viewModel.getData()
            XCTAssert(articlesVC.arrayOfItems.count == 0, "No data found!")
        }
        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testExample() throws {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
        }

        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }

    }
