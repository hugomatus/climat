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
  
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "f1f88a9acc94bde45346f66fb09a1804"
  
  let weatherDataModel = WeatherDataModel()
  let locationManager = CLLocationManager()
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherDescription: UILabel!
  @IBOutlet weak var weatherIconImage: UIImageView!
  @IBOutlet weak var currentTempLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  /**
   * Get location and call Open WeatherAPI for weather details
   **/
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    //get the most recent location
    let location = locations[locations.count-1]
    
    if location.horizontalAccuracy > 0 {
      
      locationManager.stopUpdatingLocation();
      
      let latitude = location.coordinate.longitude
      let longitude = location.coordinate.longitude
      
      print("logitude: \(longitude) lattitude: \(latitude)")
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APP_ID]
      
      let weatherDataModel = getWeatherData(parameters: params)
      
      updateUI(weatherDataModel: weatherDataModel)
    }
    
  }
  
  /**
   *
   **/
  func updateUI(weatherDataModel: WeatherDataModel) {
    
    cityLabel.text = weatherDataModel.cityName
    weatherDescription.text = weatherDataModel.weatherDescription
    currentTempLabel.text = "\(String(describing: weatherDataModel.temp))"
    
  }
  
  /**
   * Fetches Weather Data from Open Weather API and returns WeatherDataModel
   **/
  func getWeatherData(parameters: [String : String]) -> WeatherDataModel {
    
    let weatherDataModel = WeatherDataModel()
    
    weatherDataModel.cityName = "Portland"
    weatherDataModel.weatherDescription = "Heavy Rain"
    weatherDataModel.temp = 55.0
    
    
    return weatherDataModel
  }
  
  
  
  
  
  
}

