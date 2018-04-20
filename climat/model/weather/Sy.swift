//
//  Sy.swift
//  climat
//
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//
import Foundation 
import SwiftyJSON

class Sy{

	var country : String!
	var id : Int!
	var message : Double!
	var sunrise : Int!
	var sunset : Int!
	var type : Int!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		country = json["country"].stringValue
		id = json["id"].intValue
		message = json["message"].doubleValue
		sunrise = json["sunrise"].intValue
		sunset = json["sunset"].intValue
		type = json["type"].intValue
	}

}
