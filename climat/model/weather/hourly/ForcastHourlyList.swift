//
//	DataModelList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ForcastHourlyList : NSObject, NSCoding{

	var clouds : ForecastHourlyCloud!
	var dt : Int!
	var dtTxt : String!
	var main : ForcastHourlyMain!
	var snow : ForecastHourlySnow!
	var sys : ForecastHourlySy!
	var weather : [ForecastHourlyWeather]!
	var wind : ForecastHourlyWind!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		let cloudsJson = json["clouds"]
		if !cloudsJson.isEmpty{
			clouds = ForecastHourlyCloud(fromJson: cloudsJson)
		}
		dt = json["dt"].intValue
		dtTxt = json["dt_txt"].stringValue
		let mainJson = json["main"]
		if !mainJson.isEmpty{
			main = ForcastHourlyMain(fromJson: mainJson)
		}
		let snowJson = json["snow"]
		if !snowJson.isEmpty{
			snow = ForecastHourlySnow(fromJson: snowJson)
		}
		let sysJson = json["sys"]
		if !sysJson.isEmpty{
			sys = ForecastHourlySy(fromJson: sysJson)
		}
		weather = [ForecastHourlyWeather]()
		let weatherArray = json["weather"].arrayValue
		for weatherJson in weatherArray{
			let value = ForecastHourlyWeather(fromJson: weatherJson)
			weather.append(value)
		}
		let windJson = json["wind"]
		if !windJson.isEmpty{
			wind = ForecastHourlyWind(fromJson: windJson)
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
         clouds = aDecoder.decodeObject(forKey: "clouds") as? ForecastHourlyCloud
         dt = aDecoder.decodeObject(forKey: "dt") as? Int
         dtTxt = aDecoder.decodeObject(forKey: "dt_txt") as? String
         main = aDecoder.decodeObject(forKey: "main") as? ForcastHourlyMain
         snow = aDecoder.decodeObject(forKey: "snow") as? ForecastHourlySnow
         sys = aDecoder.decodeObject(forKey: "sys") as? ForecastHourlySy
         weather = aDecoder.decodeObject(forKey: "weather") as? [ForecastHourlyWeather]
         wind = aDecoder.decodeObject(forKey: "wind") as? ForecastHourlyWind

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
