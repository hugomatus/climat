//
//  WeatherDataModel.swift
//  climat
//
//  Created by Hugo  Matus on 4/7/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation

class WeatherDataModel {
  
  //city
  let cityId : Int? = nil
  let cityName : String? = nil
  let cityCode : Int? = nil
  
  //sys
  let country : String? = nil
  let sunriseUTC : Int? = nil
  let sunsetTUC : Int? = nil
  
  //Weather condition codes
  let weatherId: Int? = nil
  
  //Group of weather parameters (Rain, Snow, Extreme etc.)
  let weatherMain: String? = nil
  //Weather condition within the group
  let weatherDescription: String? = nil
  let weatherIcon: String? = nil
  
  //main
  let temp : Double? = nil
  let presure : Int? = nil
  let humidity : Int? = nil
  let tempMin : Double? = nil
  let tempMax : Double? = nil
  
  //wind
  let windSpeed : Double? = nil
  let windDeg: Double? = nil
  
  //rain: Rain volume for the last 3 hours
  let rainInLastThreeHours : Double? = nil
  
  //clouds: Cloudiness
  let cloundsAll: Double? = nil
  
  func convertFahrenheitToCelsius(tempInFahrenheit:Double) ->Double {
    let celsius = (tempInFahrenheit - 32.0) * (5.0/9.0)
    return celsius as Double
  }
  
  func convertCelsiusToFahrenheit(tempInCelsius:Double) ->Double {
    let fahrenheit = (tempInCelsius * 9.0/5.0) + 32.0
    return fahrenheit as Double
  }
}


