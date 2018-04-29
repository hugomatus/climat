//
//  APISearchType.swift
//  climat
//
//  Created by Hugo  Matus on 4/22/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation

enum APISearchType: String {
  
  case currentWeather = "http://api.openweathermap.org/data/2.5/weather"
  case forecastHourly = "http://api.openweathermap.org/data/2.5/forecast"
  case forecastDaily = "http://api.openweathermap.org/data/2.5/forecast/daily"
  case imageSearch = "http://openweathermap.org/img/w/"
  case apiKey = "f1f88a9acc94bde45346f66fb09a1804"
  //b410567cd9e39037 weather underground
}
