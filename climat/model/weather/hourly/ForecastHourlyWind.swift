//
//	DataModelWind.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForecastHourlyWind : NSObject, NSCoding{

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

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if deg != nil{
			dictionary["deg"] = deg
		}
		if speed != nil{
			dictionary["speed"] = speed
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         deg = aDecoder.decodeObject(forKey: "deg") as? Float
         speed = aDecoder.decodeObject(forKey: "speed") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if deg != nil{
			aCoder.encode(deg, forKey: "deg")
		}
		if speed != nil{
			aCoder.encode(speed, forKey: "speed")
		}

	}

}
