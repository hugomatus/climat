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
 *  Facade for WeatherAPI
 **/
final class WeatherAPI {
  
  let API_URL = "http://api.openweathermap.org/data/2.5/weather"
  let API_IMAGE_URL = "http://openweathermap.org/img/w/"
  let APP_ID = "f1f88a9acc94bde45346f66fb09a1804"
  
  let weatherDataModel : WeatherDataModel!
  
  init() {
    weatherDataModel = WeatherDataModel()
  }
  
  func getWeatherOpenWeatherData(parameters : [String : String], completionHandler:@escaping (_ payloadJSON: (JSON)) -> Void) {
    
    print("start weather data downloading...")
    
    Alamofire.request(API_URL, method: .get, parameters: parameters).responseJSON {
      response in
      
      guard response.result.error == nil else {
        print("error calling GET ")
        print(response.result.error!)
        completionHandler("error calling GET ")
        return
      }
      
      if (response.result.isSuccess) {
        print("Success! Got the Weather Data")
        let payload : JSON = JSON(response.result.value!)
        print(payload)
        self.parse(jsonData: payload)
        self.getWeatherOpenWeatherDataImage(weatherIconImageName: ("\(String(describing: self.weatherDataModel.weatherIcon!)).png")) { (weatherIcon) in
          self.weatherDataModel.weatherIconImage = weatherIcon
          completionHandler(payload)
        }
      } else {
        completionHandler("Error occured while trying to parse data")
        print("Error\(response.error!)")
      }
      
    }
  }
  
  func parse(jsonData: JSON)  {
    
    if let tempResult = jsonData["main"]["temp"].double {
      weatherDataModel.temp = (tempResult - 273.15)
      weatherDataModel.tempMin = (jsonData["main"]["temp_min"].double! - 273.15)
      weatherDataModel.tempMax = (jsonData["main"]["temp_max"].double! - 273.15)
      weatherDataModel.humidity = (jsonData["main"]["humidity"].int!)
      weatherDataModel.presure = (jsonData["main"]["pressure"].int!)
      weatherDataModel.windSpeed = (jsonData["wind"]["speed"].double!)
      weatherDataModel.cityName = jsonData["name"].stringValue
      weatherDataModel.weatherDescription = jsonData["weather"][0]["description"].stringValue
      weatherDataModel.sunriseUTC = jsonData["sys"]["sunrise"].int
      weatherDataModel.sunsetTUC = jsonData["sys"]["sunset"].int
      
      //weather condition codes - extract from API site
      weatherDataModel.weatherId = jsonData["weather"][0]["id"].intValue
      weatherDataModel.weatherIcon = jsonData["weather"][0]["icon"].stringValue
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
        print("image downloaded: \(image)")
        //self.weatherDataModel.weatherIconImage = image
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
}


