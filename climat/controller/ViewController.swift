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
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APISearchType.apiKey.rawValue]
      
      fetchWeatherCurrent(params)
      
      fetchWeatherForecastHourly(params)
      
      let params2 : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : APISearchType.apiKey.rawValue, "cnt":"6"]
      
      fetchWeatherForecastDaily(params2)
    }
  }
  
  func updateUIWithWeatherData(dataModel : OpenWeatherDataModel) {
    
    cityLabel.text = dataModel.name
    let tempF = Int(dataModel.KtoF(kelvin:dataModel.main.temp).rounded())
    currentTempLabel.text = String(tempF)+" ℉"
    weatherDescription.text = dataModel.weather[0].descriptionField.capitalizingFirstLetter()
    weatherIconImage.image = dataModel.weatherIconImage
    minTempLabel.text = "\(Int(dataModel.KtoF(kelvin:dataModel.main.tempMin!).rounded())) ℉"
    maxTempLabel.text = "\(Int(dataModel.KtoF(kelvin:dataModel.main.tempMax!).rounded())) ℉"
    sunRiseLabel.text = weatherAPI.getReadableDate(timeStamp: TimeInterval(dataModel.sys.sunrise!))
    sunSetLabel.text = weatherAPI.getReadableDate(timeStamp: TimeInterval(dataModel.sys.sunset!))
  }
  
  @IBOutlet weak var forecastTableData: UITableView!
  
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
      
      let params : [String : String] = ["q" : city, "appid" : APISearchType.apiKey.rawValue]
      
      fetchWeatherCurrent(params)
      
      fetchWeatherForecastHourly(params)
      
      fetchWeatherForecastDaily(params)
    }
    
  }
  
  fileprivate func fetchWeatherCurrent(_ params: [String : String]) {
    weatherAPI.getWeatherForecastCurrent(parameters: params) { (dataModel) in
      self.updateUIWithWeatherData(dataModel: dataModel)
    }
  }
  
  fileprivate func fetchWeatherForecastHourly(_ params: [String : String]) {
    weatherAPI.getWeatherForecastHourly(parameters: params) { (dataModel) in
      for index in 0...5 {
      
        self.forecastWeatherIconImage[index].image = dataModel.list[index].weather[0].weatherIconImage
      
        let dateTimeOfForecast = self.weatherAPI.getReadableDate(timeStamp:TimeInterval(dataModel.list[index].dt))
        
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
      for index in 0...5 {
        
        self.forecastWeatherIconImage[index].image = dataModel.list[index].weather[0].weatherIconImage
        
        self.forecastWeatherDailyDayLabel[index].text = self.weatherAPI.getDay(timeStamp: TimeInterval(dataModel.list[index].dt))
        
        self.forecastWeatherDailyMinTempLabel[index].text =
          
        "\(Int(self.weatherAPI.KtoF(kelvin: Float(dataModel.list[index].temp.min))))℉"
        
        self.forecastWeatherDailyMaxTempLabel[index].text =
          
        "\(Int(self.weatherAPI.KtoF(kelvin: Float(dataModel.list[index].temp.max))))℉"
      }
    }
  }
}

