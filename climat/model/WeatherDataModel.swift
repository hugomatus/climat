//
//  WeatherDataModel.swift
//  climat
//
//  Created by Hugo  Matus on 4/7/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation
import UIKit

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
  var weatherIconImage: UIImage? = nil
  
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
  
  func getWindDirection() {
    
//    var degrees = windDeg
//    var windDirection : String
//
//    if 348.75 <= degrees.is && degrees <= 360 {
//      windDirection = "N"
//    } else if 0 <= degrees,degrees <= 11.25 {
//      windDirection = "N"
//    } else if 11.25 < degrees, degrees <= 33.75 {
//      windDirection = "NNE"
//    } else if 33.75 < degrees, degrees <= 56.25 {
//      windDirection = "NE"
//    } else if 56.25 < degrees, degrees <= 78.75 {
//      windDirection = "ENE"
//    } else if 78.75 < degrees, degrees <= 101.25 {
//      windDirection = "E"
//    } else if 101.25 < degrees, degrees <= 123.75 {
//      windDirection = "ESE"
//    } else if 123.75 < degrees, degrees <= 146.25 {
//      windDirection = "SE"
//    } else if 146.25 < degrees, degrees <= 168.75 {
//      windDirection = "SSE"
//    } else if 168.75 < degrees, degrees <= 191.25 {
//      windDirection = "S"
//    } else if 191.25 < degrees, degrees <= 213.75 {
//      windDirection = "SSW"
//    } else if 213.75 < degrees, degrees <= 236.25 {
//      windDirection = "SW"
//    } else if 236.25 < degrees, degrees <= 258.75 {
//      windDirection = "WSW"
//    } else if 258.75 < degrees, degrees <= 281.25 {
//      windDirection = "W"
//    } else if 281.25 < degrees, degrees <= 303.75 {
//      windDirection = "WNW"
//    } else if 303.75 < degrees, degrees <= 326.25 {
//      windDirection = "NW"
//    } else if 326.25 < degrees, degrees < 348.75 {
//      windDirection = "NNW"
//    }
 }
}


