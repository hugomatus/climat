//
//  DateHelper.swift
//  climat
//
//  Created by Hugo  Matus on 5/3/18.
//  Copyright © 2018 Hugo  Matus. All rights reserved.
//

import Foundation


public extension Date {
  
  init(timeStamp: TimeInterval) {
    self = Date(timeIntervalSince1970: timeStamp)
  }
  
  init(millsec : Int) {
    let timeStamp = TimeInterval(millsec)
    self = Date(timeIntervalSince1970: timeStamp)
  }
  
  func toMillis() -> Int64! {
    return Int64(self.timeIntervalSince1970 * 1000)
  }
  
  var fullDate : String {
    // Customize a date formatter
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    
    return formatter.string(from: self)
  }
  
  func formatDate(_ dateStyle : DateFormatter.Style) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    return formatter.string(from: self)
    
  }
  var hours : String {
    
    // Customize a date formatter
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    
    return formatter.string(from: self)
  }
  
  /**
   returns day of the week
   - returns: The Response as a JSON object
   */
  var dayOfWeek : String  {
    // Customize a date formatter
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    
    return formatter.string(from: self)
  }
  
  /**
   returns readable date
   - returns: The Response as a JSON object
   */
  var readableDate :  String {
    let dateFormatter = DateFormatter()
    
    if Calendar.current.isDateInTomorrow(self) {
      //return "Tomorrow"
      dateFormatter.dateFormat = "h:mm a"
      return "\(dateFormatter.string(from: self))"
    } else if Calendar.current.isDateInYesterday(self) {
      //return "Yesterday"
      dateFormatter.dateFormat = "h:mm a"
      return dateFormatter.string(from: self)
    } else if self.dateFallsInCurrentWeek {
      if Calendar.current.isDateInToday(self) {
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
      } else {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
      }
    } else {
      dateFormatter.dateFormat = "MMM d, yyyy"
      return dateFormatter.string(from: self)
    }
  }
  
  var dateFallsInCurrentWeek : Bool {
    let currentWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: Date())
    let datesWeek = Calendar.current.component(Calendar.Component.weekOfYear, from: self)
    return (currentWeek == datesWeek)
  }
  
}
