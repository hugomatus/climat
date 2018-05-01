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
}
