//
//	DataModelList.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForcastHourlyList {

	var clouds : ForecastHourlyCloud!
	var dt : Int!
	var dtTxt : String!
	var main : ForcastHourlyMain!
	var snow : ForecastHourlySnow!
	var sys : ForecastHourlySy!
	var weather : [ForecastHourlyWeather]!
	var wind : ForecastHourlyWind!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let cloudsJson = json["clouds"]
		if !cloudsJson.isEmpty{
			clouds = ForecastHourlyCloud(fromJson: cloudsJson)
		}
		dt = json["dt"].intValue
		dtTxt = json["dt_txt"].stringValue
		let mainJson = json["main"]
		if !mainJson.isEmpty{
			main = ForcastHourlyMain(fromJson: mainJson)
		}
		let snowJson = json["snow"]
		if !snowJson.isEmpty{
			snow = ForecastHourlySnow(fromJson: snowJson)
		}
		let sysJson = json["sys"]
		if !sysJson.isEmpty{
			sys = ForecastHourlySy(fromJson: sysJson)
		}
		weather = [ForecastHourlyWeather]()
		let weatherArray = json["weather"].arrayValue
		for weatherJson in weatherArray{
			let value = ForecastHourlyWeather(fromJson: weatherJson)
			weather.append(value)
		}
		let windJson = json["wind"]
		if !windJson.isEmpty{
			wind = ForecastHourlyWind(fromJson: windJson)
		}
	}
}
