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

extension String {
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + dropFirst()
  }
  
  mutating func capitalizeFirstLetter() {
    self = self.capitalizingFirstLetter()
  }
  
  var isNilOrEmpty: Bool {
    return self.trimmingCharacters(in: .whitespaces).isEmpty
  }
}

extension Optional where Wrapped == String {
  var isNilOrEmpty: Bool {
    return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
  }
}



/**
 Service Facade: Fetches Weather Data from OpenWeatherAPI
 */
final class WeatherAPI {
  
  let API_URL = "http://api.openweathermap.org/data/2.5/weather"
  let API_IMAGE_URL = "http://openweathermap.org/img/w/"
  let APP_ID = "f1f88a9acc94bde45346f66fb09a1804"
  
  /**
   Fetches Weather Data and Parses the JSON string into a JSON object
   
   - parameter parameters: The Request Parameters
   
   - parameter completionHandler: The Callback Handler
   
   - returns: The Response as a JSON object
   */
  func getWeatherOpenWeatherData(parameters : [String : String], completionHandler:@escaping (_ dataModel: (OpenWeatherDataModel)) -> Void) {
    
    let dataModel = OpenWeatherDataModel()
    
    
    Alamofire.request(API_URL, method: .get, parameters: parameters).responseJSON {
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
        dataModel.parse(fromJson: payload)
       
        guard dataModel.weather != nil && !dataModel.weather.isEmpty else {
          return
        }
        
        self.getWeatherOpenWeatherDataImage(weatherIconImageName: ("\(String(describing: dataModel.weather[0].icon!)).png")) { (weatherIcon) in
          dataModel.weatherIconImage = weatherIcon
          completionHandler(dataModel)
        }
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
    
    Alamofire.request(API_IMAGE_URL+weatherIconImageName).responseImage {
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
  
  func getReadableDate(timeStamp: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dateFormatter = DateFormatter()
    
    if Calendar.current.isDateInTomorrow(date) {
      //return "Tomorrow"
      dateFormatter.dateFormat = "h:mm a"
      return dateFormatter.string(from: date)
    } else if Calendar.current.isDateInYesterday(date) {
      //return "Yesterday"
      dateFormatter.dateFormat = "h:mm a"
      return dateFormatter.string(from: date)
    } else if dateFallsInCurrentWeek(date: date) {
      if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
      } else {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
      }
    } else {
      dateFormatter.dateFormat = "MMM d, yyyy"
      return dateFormatter.string(from: date)
    }
  }
  
  func dateFallsInCurrentWeek(date: Date) -> Bool {
    let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
    let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
    return (currentWeek == datesWeek)
  }
  
  func KtoC(kelvin : Float)->Float{
    
    return kelvin-273.15
  }
  
  func KtoF(kelvin : Float)->Float{
    
    return ((kelvin-273.15)*1.8)+32
  }
  
  func KtoR(kelvin : Float)->Float{
    
    return ((kelvin-273.15)*1.8)+491.67
  }
  
  
  func getWindDirection(degrees: Float) -> String {
    
    var windDirection : String = "NA"
    
    if 348.75 <= degrees, degrees <= 360 {
      windDirection = "North"
    } else if 0 <= degrees,degrees <= 11.25 {
      windDirection = "North"
    } else if 11.25 < degrees, degrees <= 33.75 {
      windDirection = "NNE"
    } else if 33.75 < degrees, degrees <= 56.25 {
      windDirection = "NE"
    } else if 56.25 < degrees, degrees <= 78.75 {
      windDirection = "ENE"
    } else if 78.75 < degrees, degrees <= 101.25 {
      windDirection = "East"
    } else if 101.25 < degrees, degrees <= 123.75 {
      windDirection = "ESE"
    } else if 123.75 < degrees, degrees <= 146.25 {
      windDirection = "SE"
    } else if 146.25 < degrees, degrees <= 168.75 {
      windDirection = "SSE"
    } else if 168.75 < degrees, degrees <= 191.25 {
      windDirection = "South"
    } else if 191.25 < degrees, degrees <= 213.75 {
      windDirection = "SSW"
    } else if 213.75 < degrees, degrees <= 236.25 {
      windDirection = "SW"
    } else if 236.25 < degrees, degrees <= 258.75 {
      windDirection = "WSW"
    } else if 258.75 < degrees, degrees <= 281.25 {
      windDirection = "West"
    } else if 281.25 < degrees, degrees <= 303.75 {
      windDirection = "WNW"
    } else if 303.75 < degrees, degrees <= 326.25 {
      windDirection = "NW"
    } else if 326.25 < degrees, degrees < 348.75 {
      windDirection = "NNW"
    }
    
    return windDirection
  }
}


