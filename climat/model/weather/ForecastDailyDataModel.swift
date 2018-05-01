//
//	ForecastDailyDataModel.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.

import Foundation 
import SwiftyJSON


class ForecastDailyDataModel {
  
  var city : ForecastDailyCity!
  var cnt : Int!
  var cod : String!
  var list : [ForecastDailyList]!
  var message : Int!
  var status: Bool = true
  var errorMsg: String = ""
  
  /**
   * Instantiate the instance using the passed json values to set the properties values
   */
  func parse(fromJson json: JSON!){
    if json.isEmpty{
      return
    }
    let cityJson = json["city"]
    if !cityJson.isEmpty{
      city = ForecastDailyCity(fromJson: cityJson)
    }
    cnt = json["cnt"].intValue
    cod = json["cod"].stringValue
    list = [ForecastDailyList]()
    let listArray = json["list"].arrayValue
    for listJson in listArray{
      let value = ForecastDailyList(fromJson: listJson)
      list.append(value)
    }
    message = json["message"].intValue
  }
}
