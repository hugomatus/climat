//
//  climatTests.swift
//  climatTests
//
//  Created by Hugo  Matus on 4/15/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import XCTest

@testable import climat

class climatTests: XCTestCase {
  
  var weatherAPIUnderTest : WeatherAPI!
  
  override func setUp() {
    super.setUp()
    weatherAPIUnderTest = WeatherAPI()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
    weatherAPIUnderTest = nil
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testWeatherAPI() {
    
//    let params = ["lat" : "45.3583829803815", "lon" : "122.621515710021", "appid" : weatherAPIUnderTest.APP_ID]
//
//    weatherAPIUnderTest.getWeatherOpenWeatherData(parameters: params) { (payloadJSON) in
//      print("Test Result \(payloadJSON)")
//      //self.handleData(data: payloadJSON)
//    }
    
    XCTAssert(weatherAPIUnderTest.weatherDataModel != nil)
    
  }
}
