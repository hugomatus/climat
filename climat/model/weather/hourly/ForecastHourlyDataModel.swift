//
//	DataModelOpenWeather.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForecastHourlyDataModel {

	var city : ForecastHourlyCity!
	var cnt : Int!
	var cod : String!
	var list : [ForcastHourlyList]!
	var message : Float!
  var status: Bool = true
  var errorMsg: String = ""

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
  

  func parse (fromJson json: JSON!){
    if json.isEmpty{
      return
    }
    let cityJson = json["city"]
    if !cityJson.isEmpty{
      city = ForecastHourlyCity(fromJson: cityJson)
    }
    cnt = json["cnt"].intValue
    cod = json["cod"].stringValue
    list = [ForcastHourlyList]()
    let listArray = json["list"].arrayValue
    for listJson in listArray{
      let value = ForcastHourlyList(fromJson: listJson)
      list.append(value)
    }
    message = json["message"].floatValue
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
