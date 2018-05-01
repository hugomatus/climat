//
//	ForecastDailyCity.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.

import Foundation 
import SwiftyJSON


class ForecastDailyCity {

	var country : String!
	var geonameId : Int!
	var iso2 : String!
	var lat : Float!
	var lon : Float!
	var name : String!
	var population : Int!
	var type : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		country = json["country"].stringValue
		geonameId = json["geoname_id"].intValue
		iso2 = json["iso2"].stringValue
		lat = json["lat"].floatValue
		lon = json["lon"].floatValue
		name = json["name"].stringValue
		population = json["population"].intValue
		type = json["type"].stringValue
	}
}
