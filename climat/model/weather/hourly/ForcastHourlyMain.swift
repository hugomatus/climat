//
//	DataModelMain.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForcastHourlyMain {

	var grndLevel : Int!
	var humidity : Int!
	var pressure : Int!
	var seaLevel : Float!
	var temp : Float!
	var tempKf : Int!
	var tempMax : Float!
	var tempMin : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		grndLevel = json["grnd_level"].intValue
		humidity = json["humidity"].intValue
		pressure = json["pressure"].intValue
		seaLevel = json["sea_level"].floatValue
		temp = json["temp"].floatValue
		tempKf = json["temp_kf"].intValue
		tempMax = json["temp_max"].floatValue
		tempMin = json["temp_min"].floatValue
	}
}
