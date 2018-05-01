//
//	DataModelMain.swift
//  Created by Hugo  Matus on 4/18/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation 
import SwiftyJSON


class ForcastHourlyMain : NSObject, NSCoding{

	var grndLevel : Int!
	var humidity : Int!
	var pressure : Int!
	var seaLevel : Float!
	var temp : Float!
	var tempKf : Int!
	var tempMax : Float!
	var tempMin : Float!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		grndLevel = json["grnd_level"].intValue
		humidity = json["humidity"].intValue
		pressure = json["pressure"].intValue
		seaLevel = json["sea_level"].floatValue
		temp = json["temp"].floatValue
		tempKf = json["temp_kf"].intValue
		tempMax = json["temp_max"].floatValue
		tempMin = json["temp_min"].floatValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if grndLevel != nil{
			dictionary["grnd_level"] = grndLevel
		}
		if humidity != nil{
			dictionary["humidity"] = humidity
		}
		if pressure != nil{
			dictionary["pressure"] = pressure
		}
		if seaLevel != nil{
			dictionary["sea_level"] = seaLevel
		}
		if temp != nil{
			dictionary["temp"] = temp
		}
		if tempKf != nil{
			dictionary["temp_kf"] = tempKf
		}
		if tempMax != nil{
			dictionary["temp_max"] = tempMax
		}
		if tempMin != nil{
			dictionary["temp_min"] = tempMin
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         grndLevel = aDecoder.decodeObject(forKey: "grnd_level") as? Int
         humidity = aDecoder.decodeObject(forKey: "humidity") as? Int
         pressure = aDecoder.decodeObject(forKey: "pressure") as? Int
         seaLevel = aDecoder.decodeObject(forKey: "sea_level") as? Float
         temp = aDecoder.decodeObject(forKey: "temp") as? Float
         tempKf = aDecoder.decodeObject(forKey: "temp_kf") as? Int
         tempMax = aDecoder.decodeObject(forKey: "temp_max") as? Float
         tempMin = aDecoder.decodeObject(forKey: "temp_min") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if grndLevel != nil{
			aCoder.encode(grndLevel, forKey: "grnd_level")
		}
		if humidity != nil{
			aCoder.encode(humidity, forKey: "humidity")
		}
		if pressure != nil{
			aCoder.encode(pressure, forKey: "pressure")
		}
		if seaLevel != nil{
			aCoder.encode(seaLevel, forKey: "sea_level")
		}
		if temp != nil{
			aCoder.encode(temp, forKey: "temp")
		}
		if tempKf != nil{
			aCoder.encode(tempKf, forKey: "temp_kf")
		}
		if tempMax != nil{
			aCoder.encode(tempMax, forKey: "temp_max")
		}
		if tempMin != nil{
			aCoder.encode(tempMin, forKey: "temp_min")
		}

	}

}
