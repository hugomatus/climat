//
//  Main.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//
import Foundation 
import SwiftyJSON

class Main{

	var humidity : Int!
	var pressure : Int!
	var temp : Float!
	var tempMax : Float!
	var tempMin : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		humidity = json["humidity"].intValue
		pressure = json["pressure"].intValue
		temp = json["temp"].floatValue
		tempMax = json["temp_max"].floatValue
		tempMin = json["temp_min"].floatValue
	}

}
