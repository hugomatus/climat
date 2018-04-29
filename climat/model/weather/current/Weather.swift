//
//  Weather.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//
import Foundation 
import SwiftyJSON

class Weather{

	var descriptionField : String!
	var icon : String!
	var id : Int!
	var main : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		descriptionField = json["description"].stringValue
		icon = json["icon"].stringValue
		id = json["id"].intValue
		main = json["main"].stringValue
	}

}
