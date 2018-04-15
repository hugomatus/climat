//
//  ViewController.swift
//  climat
//
//  Created by Hugo  Matus on 4/7/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import UIKit
import CoreLocation

import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  //  https://openweathermap.org/weather-conditions
  //  How to get icon URL
  //  For code 501 - moderate rain icon = "10d"
  //  URL is
  //  http://openweathermap.org/img/w/10d.png
  
  let API_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "f1f88a9acc94bde45346f66fb09a1804"
  
  let weatherDataModel = WeatherDataModel()
  let locationManager = CLLocationManager()
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherDescription: UILabel!
  @IBOutlet weak var weatherIconImage: UIImageView!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  @IBOutlet weak var sunRiseLabel: UILabel!
  @IBOutlet weak var sunSetLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  /**
   * Get location and call Open WeatherAPI for weather details
   **/
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    //get the most recent location
    let location = locations[locations.count-1]
    
    if location.horizontalAccuracy > 0 {
      
      locationManager.stopUpdatingLocation();
      
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      
      print("logitude: \(longitude) lattitude: \(latitude)")
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APP_ID]
      getWeatherData(parameters: params)
      
    }
  }
  
  
  /**
   * Fetches Weather Icon from Open Weather
   **/
  func getWeatherIconImage(weatherIconImageName : String) {
    
    print("start weather image downloading...")
    
    Alamofire.request("http://openweathermap.org/img/w/"+weatherIconImageName).responseImage {
      response in
      debugPrint(response)
      print(response.request!)
      print(response.response!)
      debugPrint(response.result)
      
      if let image = response.result.value {
        print("image downloaded: \(image)")
        self.updateWeatherIcon(iconImage: image)
      }
    }
  }
  
  /**
   * Fetches Weather Data from Open Weather API and returns WeatherDataModel
   **/
  func getWeatherData(parameters: [String : String])  {
    
    print("start weather data downloading...")
    
    Alamofire.request(API_URL, method: .get, parameters: parameters).responseJSON {
      response in
      if (response.result.isSuccess) {
        print("Success! Got the Weather Data")
        let weatherJSON : JSON = JSON(response.result.value!)
        print(weatherJSON)
        self.updateWeatherData(json: weatherJSON)
        print(("Image here: \(String(describing: self.weatherDataModel.weatherIcon!)).png"))
        self.getWeatherIconImage(weatherIconImageName: ("\(String(describing: self.weatherDataModel.weatherIcon!)).png"))
        self.updateWeatherIcon(iconImage: self.weatherDataModel.weatherIconImage)
      } else {
        print("Error\(response.error!)")
        self.cityLabel.text = "Connection Issue"
      }
    }
  }
  
  func updateWeatherData(json: JSON) {
    if let tempResult = json["main"]["temp"].double {
      weatherDataModel.temp = (tempResult - 273.15)
      weatherDataModel.tempMin = (json["main"]["temp_min"].double! - 273.15)
      weatherDataModel.tempMax = (json["main"]["temp_max"].double! - 273.15)
      weatherDataModel.humidity = (json["main"]["humidity"].int!)
      weatherDataModel.presure = (json["main"]["pressure"].int!)
      weatherDataModel.windSpeed = (json["wind"]["speed"].double!)
      weatherDataModel.cityName = json["name"].stringValue
      weatherDataModel.weatherDescription = json["weather"][0]["description"].stringValue
      weatherDataModel.sunriseUTC = json["sys"]["sunrise"].int
      weatherDataModel.sunsetTUC = json["sys"]["sunset"].int
      //weather condition codes - extract from API site
      weatherDataModel.weatherId = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIcon = json["weather"][0]["icon"].stringValue
      
      print("City \(String(describing: weatherDataModel.cityName))")
      
      
    } else {
      cityLabel.text = "Weather Unavailable"
    }
    
    updateUIWithWeatherData()
  }
  
  func updateWeatherIcon(iconImage : UIImage!) {
    
    weatherDataModel.weatherIconImage = iconImage
    weatherIconImage.image = iconImage
  }
  
  //MARK: - UI Updates
  func updateUIWithWeatherData() {
    
    cityLabel.text = weatherDataModel.cityName
    let tempF = Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.temp!).rounded())
    cityLabel.text = weatherDataModel.cityName
    weatherDescription.text = weatherDataModel.weatherDescription
    currentTempLabel.text = String(tempF)+" ℉"
    print("Weather Image \(String(describing: weatherDataModel.weatherIconImage))")
    weatherIconImage.image = weatherDataModel.weatherIconImage
    minTempLabel.text = "\(Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.tempMin!).rounded())) ℉"
    maxTempLabel.text = "\(Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.tempMax!).rounded())) ℉"
    
    print("sunrise: \(String(describing: getReadableDate(timeStamp: TimeInterval(weatherDataModel.sunriseUTC!))))")
    
    sunRiseLabel.text = getReadableDate(timeStamp: TimeInterval(weatherDataModel.sunriseUTC!))
    
    
    sunSetLabel.text = getReadableDate(timeStamp: TimeInterval(weatherDataModel.sunsetTUC!))
    
    windSpeedLabel.text = "\(weatherDataModel.windSpeed!) m/h"
    humidityLabel.text = "\(weatherDataModel.humidity!) %"
  }
  
  func getReadableDate(timeStamp: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeStamp)
    let dateFormatter = DateFormatter()
    
    if Calendar.current.isDateInTomorrow(date) {
      return "Tomorrow"
    } else if Calendar.current.isDateInYesterday(date) {
      return "Yesterday"
    } else if dateFallsInCurrentWeek(date: date) {
      if Calendar.current.isDateInToday(date) {
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
      } else {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
      }
    } else {
      dateFormatter.dateFormat = "MMM d, yyyy"
      return dateFormatter.string(from: date)
    }
  }
  
  func dateFallsInCurrentWeek(date: Date) -> Bool {
    let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
    let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: date)
    return (currentWeek == datesWeek)
  }
}

