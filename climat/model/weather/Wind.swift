//
//  Wind.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//
import Foundation 
import SwiftyJSON

class Wind{

	var deg : Float!
	var speed : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		deg = json["deg"].floatValue
		speed = json["speed"].floatValue
	}

}
