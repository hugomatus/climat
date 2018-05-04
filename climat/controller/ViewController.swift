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

class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
  let weatherAPI = WeatherAPI()
  let locationManager = CLLocationManager()
  
  //Current Weather
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var weatherDescription: UILabel!
  @IBOutlet weak var weatherIconImage: UIImageView!
  @IBOutlet weak var currentTempLabel: UILabel!
  @IBOutlet weak var minTempLabel: UILabel!
  @IBOutlet weak var maxTempLabel: UILabel!
  @IBOutlet weak var sunRiseLabel: UILabel!
  @IBOutlet weak var sunSetLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  
  //Hourly Forecast
  @IBOutlet var forecastWeatherConditionTimeLabel: [UILabel]!
  @IBOutlet var forecastWeatherIconImage: [UIImageView]!
  @IBOutlet var forecastWeatherIconIConditionLabel: [UILabel]!
  
  
  //Daily Forecast
  @IBOutlet var forecastWeatherDailyDayLabel: [UILabel]!
  @IBOutlet var forecastWeatherDailyIconImage: [UIImageView]!
  @IBOutlet var forecastWeatherDailyMinTempLabel: [UILabel]!
  @IBOutlet var forecastWeatherDailyMaxTempLabel: [UILabel]!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let now = Date()
    let currentTimeFormatter = DateFormatter()
    
    currentTimeFormatter.dateStyle = .full
    dateTimeLabel.text = currentTimeFormatter.string(from: now)
    
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
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APISearchType.apiKey.rawValue, "cnt":"7"]
      
      fetchWeatherCurrent(params)
      
      fetchWeatherForecastHourly(params)
      
      let params2 : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APISearchType.apiKey.rawValue, "cnt":"7"]
      
      fetchWeatherForecastDaily(params)
    }
  }
  
  @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
    
    viewDidLoad()
  }
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "changeCityName" {
      
      let destinationVC = segue.destination as! ChangeCityViewController
      
      destinationVC.delegate = self
      
    }
  }
  
  func userEnteredANewCityName(city: String) {
    
    if !city.isNilOrEmpty {
      let params : [String : String] = ["q" : city, "appid" : APISearchType.apiKey.rawValue,"cnt":"7"]
      
      fetchWeatherCurrent(params)
      
      fetchWeatherForecastHourly(params)
      
      fetchWeatherForecastDaily(params)
      
      //TimeZone.
    }
    
  }
  
  fileprivate func fetchWeatherCurrent(_ params: [String : String]) {
    weatherAPI.getWeatherForecastCurrent(parameters: params) { (dataModel) in
      
      self.cityLabel.text = dataModel.name
      let tempF = Int(self.weatherAPI.KtoF(kelvin:dataModel.main.temp).rounded())
      self.currentTempLabel.text = String(tempF)+" ℉"
      self.weatherDescription.text = dataModel.weather[0].descriptionField.capitalizingFirstLetter()
      self.weatherIconImage.image = dataModel.weatherIconImage
      self.minTempLabel.text = "\(Int(self.weatherAPI.KtoF(kelvin:dataModel.main.tempMin!).rounded())) ℉"
      self.maxTempLabel.text = "\(Int(self.weatherAPI.KtoF(kelvin:dataModel.main.tempMax!).rounded())) ℉"
      
      self.sunRiseLabel.text = Date(millsec: (dataModel.sys.sunrise!)).readableDate
      self.sunSetLabel.text = Date(millsec: (dataModel.sys.sunset!)).readableDate
      
    }
  }
  
  fileprivate func fetchWeatherForecastHourly(_ params: [String : String]) {
    weatherAPI.getWeatherForecastHourly(parameters: params) { (dataModel) in
      for index in 0...5 {
        
        self.forecastWeatherIconImage[index].image = dataModel.list[index].weather[0].weatherIconImage
        
        let dateTimeOfForecast = Date(millsec: dataModel.list[index].dt).readableDate
        
        let timeForecast = dateTimeOfForecast.split(separator: " ")[0].split(separator: ":")[0]
        let amPMTimeForecast = dateTimeOfForecast.split(separator: " ")[1]
        
        self.forecastWeatherConditionTimeLabel[index].text = "\(timeForecast)\(amPMTimeForecast)"
        
        self.forecastWeatherIconIConditionLabel[index].text =
          
        "\(Int(self.weatherAPI.KtoF(kelvin: Float(dataModel.list[index].main.temp))))℉"
      }
    }
  }
  
  fileprivate func fetchWeatherForecastDaily(_ params: [String : String]) {
    weatherAPI.getWeatherForecastDaily(parameters: params) { (dataModel) in
      for index in 1...6 {
        
        self.forecastWeatherDailyIconImage[index-1].image = dataModel.list[index].weather[0].weatherIconImage
        
        print("\(Date(timeStamp: TimeInterval(dataModel.list[index].dt)).formatDate(.full))")
        
        let f = Date(timeStamp: TimeInterval(dataModel.list[index].dt)).dayOfWeek
        
        self.forecastWeatherDailyDayLabel[index-1].text = f
        
        self.forecastWeatherDailyMinTempLabel[index-1].text =
          
        "\(Int(self.weatherAPI.KtoF(kelvin: Float(dataModel.list[index].temp.min))))℉"
        
        self.forecastWeatherDailyMaxTempLabel[index-1].text =
          
        "\(Int(self.weatherAPI.KtoF(kelvin: Float(dataModel.list[index].temp.max))))℉"
      }
    }
  }
}

