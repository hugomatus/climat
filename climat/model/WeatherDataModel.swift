//
//  WeatherDataModel.swift
//  climat
//
//  Created by Hugo  Matus on 4/7/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation

class WeatherDataModel {
  //var downloadURL = NSURL(string: "http://cdn.sstatic.net/Sites/stackoverflow/company/Img/photos/big/6.jpg?v=f4b7c5fee820")!
  //imageView.af_setImageWithURL(downloadURL)
  
  //city
  var cityId : Int? = nil
  var cityName : String? = nil
  var cityCode : Int? = nil
  
  //sys
  var country : String? = nil
  var sunriseUTC : Int? = nil
  var sunsetTUC : Int? = nil
  
  //Weather condition codes
  var weatherId: Int? = nil
  
  //Group of weather parameters (Rain, Snow, Extreme etc.)
  var weatherMain: String? = nil
  //Weather condition within the group
  var weatherDescription: String? = nil
  var weatherIcon: String? = nil
  
  //main
  var temp : Double? = nil
  var presure : Int? = nil
  var humidity : Int? = nil
  var tempMin : Double? = nil
  var tempMax : Double? = nil
  
  //wind
  var windSpeed : Double? = nil
  var windDeg: Double? = nil
  
  //rain: Rain volume for the last 3 hours
  var rainInLastThreeHours : Double? = nil
  
  //clouds: Cloudiness
  var cloundsAll: Double? = nil
  
  func convertFahrenheitToCelsius(tempInFahrenheit:Double) ->Double {
    let celsius = (tempInFahrenheit - 32.0) * (5.0/9.0)
    return celsius as Double
  }
  
  func convertCelsiusToFahrenheit(tempInCelsius:Double) ->Double {
    let fahrenheit = (tempInCelsius * 9.0/5.0) + 32.0
    return fahrenheit as Double
  }
}


