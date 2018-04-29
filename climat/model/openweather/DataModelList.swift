//
//	DataModelList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class DataModelList : NSObject, NSCoding{

	var clouds : DataModelCloud!
	var dt : Int!
	var dtTxt : String!
	var main : DataModelMain!
	var snow : DataModelSnow!
	var sys : DataModelSy!
	var weather : [DataModelWeather]!
	var wind : DataModelWind!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let cloudsJson = json["clouds"]
		if !cloudsJson.isEmpty{
			clouds = DataModelCloud(fromJson: cloudsJson)
		}
		dt = json["dt"].intValue
		dtTxt = json["dt_txt"].stringValue
		let mainJson = json["main"]
		if !mainJson.isEmpty{
			main = DataModelMain(fromJson: mainJson)
		}
		let snowJson = json["snow"]
		if !snowJson.isEmpty{
			snow = DataModelSnow(fromJson: snowJson)
		}
		let sysJson = json["sys"]
		if !sysJson.isEmpty{
			sys = DataModelSy(fromJson: sysJson)
		}
		weather = [DataModelWeather]()
		let weatherArray = json["weather"].arrayValue
		for weatherJson in weatherArray{
			let value = DataModelWeather(fromJson: weatherJson)
			weather.append(value)
		}
		let windJson = json["wind"]
		if !windJson.isEmpty{
			wind = DataModelWind(fromJson: windJson)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if clouds != nil{
			dictionary["clouds"] = clouds.toDictionary()
		}
		if dt != nil{
			dictionary["dt"] = dt
		}
		if dtTxt != nil{
			dictionary["dt_txt"] = dtTxt
		}
		if main != nil{
			dictionary["main"] = main.toDictionary()
		}
		if snow != nil{
			dictionary["snow"] = snow.toDictionary()
		}
		if sys != nil{
			dictionary["sys"] = sys.toDictionary()
		}
		if weather != nil{
			var dictionaryElements = [[String:Any]]()
			for weatherElement in weather {
				dictionaryElements.append(weatherElement.toDictionary())
			}
			dictionary["weather"] = dictionaryElements
		}
		if wind != nil{
			dictionary["wind"] = wind.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         clouds = aDecoder.decodeObject(forKey: "clouds") as? DataModelCloud
         dt = aDecoder.decodeObject(forKey: "dt") as? Int
         dtTxt = aDecoder.decodeObject(forKey: "dt_txt") as? String
         main = aDecoder.decodeObject(forKey: "main") as? DataModelMain
         snow = aDecoder.decodeObject(forKey: "snow") as? DataModelSnow
         sys = aDecoder.decodeObject(forKey: "sys") as? DataModelSy
         weather = aDecoder.decodeObject(forKey: "weather") as? [DataModelWeather]
         wind = aDecoder.decodeObject(forKey: "wind") as? DataModelWind

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if clouds != nil{
			aCoder.encode(clouds, forKey: "clouds")
		}
		if dt != nil{
			aCoder.encode(dt, forKey: "dt")
		}
		if dtTxt != nil{
			aCoder.encode(dtTxt, forKey: "dt_txt")
		}
		if main != nil{
			aCoder.encode(main, forKey: "main")
		}
		if snow != nil{
			aCoder.encode(snow, forKey: "snow")
		}
		if sys != nil{
			aCoder.encode(sys, forKey: "sys")
		}
		if weather != nil{
			aCoder.encode(weather, forKey: "weather")
		}
		if wind != nil{
			aCoder.encode(wind, forKey: "wind")
		}

	}

}
