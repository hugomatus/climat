//
//  OpenWeatherDataModel.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class OpenWeatherDataModel{
  
  var base : String!
  var clouds : Cloud!
  var cod : Int!
  var coord : Coord!
  var dt : Int!
  var id : Int!
  var main : Main!
  var name : String!
  var sys : Sy!
  var visibility : Int!
  var weather : [Weather]!
  var wind : Wind!
  var status: Bool = true
  var errorMsg: String = ""
  var weatherIconImage : UIImage!
  
  /**
   * Instantiate the instance using the passed json values to set the properties values
   */
  //  init(fromJson json: JSON!){
  //    if json.isEmpty{
  //      return
  //    }
  //
  //    parse(fromJson: json)
  //  }
  
  func parse(fromJson json: JSON!) {
    
    if json.isEmpty{
      return
    }
    
    base = json["base"].stringValue
    let cloudsJson = json["clouds"]
    if !cloudsJson.isEmpty{
      clouds = Cloud(fromJson: cloudsJson)
    }
    cod = json["cod"].intValue
    let coordJson = json["coord"]
    if !coordJson.isEmpty{
      coord = Coord(fromJson: coordJson)
    }
    dt = json["dt"].intValue
    id = json["id"].intValue
    let mainJson = json["main"]
    if !mainJson.isEmpty{
      main = Main(fromJson: mainJson)
    }
    name = json["name"].stringValue
    let sysJson = json["sys"]
    if !sysJson.isEmpty{
      sys = Sy(fromJson: sysJson)
    }
    visibility = json["visibility"].intValue
    weather = [Weather]()
    let weatherArray = json["weather"].arrayValue
    for weatherJson in weatherArray{
      let value = Weather(fromJson: weatherJson)
      weather.append(value)
    }
    let windJson = json["wind"]
    if !windJson.isEmpty{
      wind = Wind(fromJson: windJson)
    }
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
