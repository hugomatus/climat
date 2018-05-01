//
//	ForecastDailyList.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.

import Foundation 
import SwiftyJSON


class ForecastDailyList {

	var clouds : Int!
	var deg : Int!
	var dt : Int!
	var humidity : Int!
	var pressure : Float!
	var snow : Float!
	var speed : Float!
	var temp : ForecastDailyTemp!
	var weather : [ForecastDailyWeather]!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		clouds = json["clouds"].intValue
		deg = json["deg"].intValue
		dt = json["dt"].intValue
		humidity = json["humidity"].intValue
		pressure = json["pressure"].floatValue
		snow = json["snow"].floatValue
		speed = json["speed"].floatValue
		let tempJson = json["temp"]
		if !tempJson.isEmpty{
			temp = ForecastDailyTemp(fromJson: tempJson)
		}
		weather = [ForecastDailyWeather]()
		let weatherArray = json["weather"].arrayValue
		for weatherJson in weatherArray{
			let value = ForecastDailyWeather(fromJson: weatherJson)
			weather.append(value)
		}
	}
}
