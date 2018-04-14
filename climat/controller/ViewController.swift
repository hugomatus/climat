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
      weatherDataModel.cityName = json["name"].stringValue
      weatherDataModel.weatherDescription = json["weather"][0]["description"].stringValue
      
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
    
  }
}

