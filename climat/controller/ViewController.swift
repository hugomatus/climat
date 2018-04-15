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
  
  let weatherAPI = WeatherAPI()
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
  
  
  //MARK: Location Handler
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    //get the most recent location
    let location = locations[locations.count-1]
    
    if location.horizontalAccuracy > 0 {
      
      locationManager.stopUpdatingLocation();
      
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      
      print("logitude: \(longitude) lattitude: \(latitude)")
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : weatherAPI.APP_ID]
      
      weatherAPI.getWeatherOpenWeatherData(parameters: params) { (payloadJSON) in
        print(payloadJSON)
       self.handleData(data: payloadJSON)
      }
      
    }
  }
  
  func handleData(data : JSON) {
    print("Callback Handler \(data)")
    weatherAPI.parse(jsonData: data)
    updateUIWithWeatherData(weatherDataModel: weatherAPI.weatherDataModel)
  }
  
  //MARK: - UI Updates
  func updateUIWithWeatherData(weatherDataModel : WeatherDataModel) {
    cityLabel.text = weatherDataModel.cityName
    let tempF = Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.temp!).rounded())
    cityLabel.text = weatherDataModel.cityName
    weatherDescription.text = weatherDataModel.weatherDescription?.capitalizingFirstLetter()
    currentTempLabel.text = String(tempF)+" ℉"
    print("Weather Image \(String(describing: weatherDataModel.weatherIconImage))")
    weatherIconImage.image = weatherDataModel.weatherIconImage
    minTempLabel.text = "\(Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.tempMin!).rounded())) ℉"
    maxTempLabel.text = "\(Int(weatherDataModel.convertCelsiusToFahrenheit(tempInCelsius:weatherDataModel.tempMax!).rounded())) ℉"
    sunRiseLabel.text = weatherAPI.getReadableDate(timeStamp: TimeInterval(weatherDataModel.sunriseUTC!))
    sunSetLabel.text = weatherAPI.getReadableDate(timeStamp: TimeInterval(weatherDataModel.sunsetTUC!))
    windSpeedLabel.text = "\(weatherDataModel.windSpeed!) m/h"
    humidityLabel.text = "\(weatherDataModel.humidity!) %"
  }
}

