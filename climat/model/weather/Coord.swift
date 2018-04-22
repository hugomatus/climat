//
//  Coord.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//
import Foundation 
import SwiftyJSON

class Coord{

	var lat : Float!
	var lon : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		lat = json["lat"].floatValue
		lon = json["lon"].floatValue
	}

}
