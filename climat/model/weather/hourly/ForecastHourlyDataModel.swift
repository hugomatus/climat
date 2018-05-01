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
}
