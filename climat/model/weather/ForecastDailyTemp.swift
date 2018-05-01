//
//	ForecastDailyTemp.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ForecastDailyTemp {

	var day : Float!
	var eve : Float!
	var max : Float!
	var min : Float!
	var morn : Float!
	var night : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		day = json["day"].floatValue
		eve = json["eve"].floatValue
		max = json["max"].floatValue
		min = json["min"].floatValue
		morn = json["morn"].floatValue
		night = json["night"].floatValue
	}
}
