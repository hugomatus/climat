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
  @IBOutlet weak var pressureLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  
  
  let now = Date()
  let calendar = Calendar.current
  let currentTimeFormatter = DateFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
      
      let params : [String : String] = ["lat" : String(latitude), "lon" : String(longitude), "appid" : weatherAPI.APP_ID]
      
      weatherAPI.getWeatherOpenWeatherData(parameters: params) { (dataModel) in
        self.updateUIWithWeatherData(dataModel: dataModel)
      }
      
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
    windSpeedLabel.text = "\(dataModel.wind.speed!) m/h \(dataModel.getWindDirection(degrees: dataModel.wind.deg))"
    humidityLabel.text = "\(dataModel.main.humidity!) %"
    pressureLabel.text = "\(dataModel.main.pressure!) hpa"
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
      let params : [String : String] = ["q" : city, "appid" : weatherAPI.APP_ID]
      
      weatherAPI.getWeatherOpenWeatherData(parameters: params) { (dataModel) in
        self.updateUIWithWeatherData(dataModel: dataModel)
      }
    }
    
  }
  
}

