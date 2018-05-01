//
//	DataModelCity.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForecastHourlyCity {

	var coord : ForecastHourlyCoord!
	var country : String!
	var id : Int!
	var name : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let coordJson = json["coord"]
		if !coordJson.isEmpty{
			coord = ForecastHourlyCoord(fromJson: coordJson)
		}
		country = json["country"].stringValue
		id = json["id"].intValue
		name = json["name"].stringValue
	}
}
