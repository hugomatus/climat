//
//  WeatherAPI.swift
//  climat
//
//  Created by Hugo  Matus on 4/15/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON



/**
 Service Facade: Fetches Weather Data from OpenWeatherAPI
 */
final class WeatherAPI {
  
  /**
   Fetches Weather Data and Parses the JSON string into a JSON object
   
   - parameter parameters: The Request Parameters
   
   - parameter completionHandler: The Callback Handler
   
   - returns: The Response as a JSON object
   */
  func getWeatherForecastCurrent(parameters : [String : String], completionHandler:@escaping (_ dataModel: (OpenWeatherDataModel)) -> Void) {
    
    let dataModel = OpenWeatherDataModel()
    
    
    Alamofire.request(APISearchType.currentWeather.rawValue, method: .get, parameters: parameters).responseJSON {
      response in
      
      guard response.result.error == nil else {
        print("error calling GET ")
        print(response.result.error!)
        
        dataModel.status = false
        dataModel.errorMsg = "error calling GET"
        completionHandler(dataModel)
        return
      }
      
      if (response.result.isSuccess) {
        print("Success! Got the Weather Data")
        
        let payload : JSON = JSON(response.result.value!)
        //        print("----------------START CURRENT CURRENT-----------------------")
        //        print(payload)
        //        print("----------------START CURRENT CURRENT-----------------------")
        dataModel.parse(fromJson: payload)
        print(payload.stringValue)
        guard dataModel.weather != nil && !dataModel.weather.isEmpty else {
          return
        }
        
        let weatherIconImage = UIImage(named: "\(String(describing: dataModel.weather[0].icon!)).png")
        dataModel.weatherIconImage = weatherIconImage
        completionHandler(dataModel)
      } else {
        dataModel.status = false
        dataModel.errorMsg = "Error occured while trying to parse data"
        completionHandler(dataModel)
        print("Error\(response.error!)")
      }
      
    }
  }
  
  /**
   Fetches Weather Data and Parses the JSON string into a JSON object
   
   - parameter parameters: The Request Parameters
   
   - parameter completionHandler: The Callback Handler
   
   - returns: The Response as a JSON object
   */
  func getWeatherForecastHourly(parameters : [String : String], completionHandler:@escaping (_ dataModel: (ForecastHourlyDataModel)) -> Void) {
    
    let dataModel = ForecastHourlyDataModel()
    
    
    Alamofire.request(APISearchType.forecastHourly.rawValue, method: .get, parameters: parameters).responseJSON {
      response in
      
      guard response.result.error == nil else {
        print("error calling GET ")
        print(response.result.error!)
        
        dataModel.status = false
        dataModel.errorMsg = "error calling GET"
        completionHandler(dataModel)
        return
      }
      
      if (response.result.isSuccess) {
        print("Success! Got the Weather Data")
        
        let payload : JSON = JSON(response.result.value!)
        //        print("----------------START HOURLY HOURLY-----------------------")
        //        print(payload)
        //        print("----------------END HOURLY HOURLY-----------------------")
        dataModel.parse(fromJson: payload)
        
        guard dataModel.list != nil && !dataModel.list.isEmpty else {
          return
        }
        
        for index in 0...dataModel.list.count-1 {
          
          for indexWeather in 0...dataModel.list[index].weather.count-1 {
            
            dataModel.list[index].weather[indexWeather].weatherIconImage = UIImage(named: "\(String(describing: dataModel.list[index].weather[indexWeather].icon!)).png")
            
          }
        }
        
        completionHandler(dataModel)
        
      } else {
        dataModel.status = false
        dataModel.errorMsg = "Error occured while trying to parse data"
        completionHandler(dataModel)
        print("Error\(response.error!)")
      }
      
    }
  }
  
  /**
   Fetches Weather Data and Parses the JSON string into a JSON object
   
   - parameter parameters: The Request Parameters
   
   - parameter completionHandler: The Callback Handler
   
   - returns: The Response as a JSON object
   */
  func getWeatherForecastDaily(parameters : [String : String], completionHandler:@escaping (_ dataModel: (ForecastDailyDataModel)) -> Void) {
    
    let dataModel = ForecastDailyDataModel()
    
    
    Alamofire.request(APISearchType.forecastDaily.rawValue, method: .get, parameters: parameters).responseJSON {
      response in
      
      guard response.result.error == nil else {
        print("error calling GET ")
        print(response.result.error!)
        
        dataModel.status = false
        dataModel.errorMsg = "error calling GET"
        completionHandler(dataModel)
        return
      }
      
      if (response.result.isSuccess) {
        print("Success! Got the Weather Data")
        
        let payload : JSON = JSON(response.result.value!)
        //        print("----------------START DAILY DAILY-----------------------")
        //        print(payload)
        //        print("----------------END DAILY DAILY-----------------------")
        dataModel.parse(fromJson: payload)
        
        guard dataModel.list != nil && !dataModel.list.isEmpty else {
          return
        }
        
        for index in 0...dataModel.list.count-1 {
          
          for indexWeather in 0...dataModel.list[index].weather.count-1 {
            
            dataModel.list[index].weather[indexWeather].weatherIconImage = UIImage(named: "\(String(describing: dataModel.list[index].weather[indexWeather].icon!)).png")
            
          }
        }
        
        completionHandler(dataModel)
        
      } else {
        dataModel.status = false
        dataModel.errorMsg = "Error occured while trying to parse data"
        completionHandler(dataModel)
        print("Error\(response.error!)")
      }
      
    }
  }
  
  private func getWeatherOpenWeatherDataImage(weatherIconImageName : String, completionHandler:@escaping (_ weatherIcon: (UIImage)) -> Void) {
    
    print("start weather image downloading...")
    
    Alamofire.request(APISearchType.imageSearch.rawValue+weatherIconImageName).responseImage {
      response in
      debugPrint(response)
      print(response.request!)
      print(response.response!)
      debugPrint(response.result)
      
      if let image = response.result.value {
        completionHandler(image)
      }
    }
  }
  
 
  
 
}
