//
//	DataModelCity.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ForecastHourlyCity : NSObject, NSCoding{

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

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if coord != nil{
			dictionary["coord"] = coord.toDictionary()
		}
		if country != nil{
			dictionary["country"] = country
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         coord = aDecoder.decodeObject(forKey: "coord") as? ForecastHourlyCoord
         country = aDecoder.decodeObject(forKey: "country") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if coord != nil{
			aCoder.encode(coord, forKey: "coord")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
