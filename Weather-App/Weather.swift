//
//  Weather.swift
//  Weather-App
//
//  Created by 조웅희 on 2016. 2. 16..
//  Copyright © 2016년 Sweet Acorn. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _location: String!
    private var _cityName: String!
    private var _name: String!
    private var _shortDescription: String!
    private var _longDescription: String!
    private var _icon: String!
    private var _day: String!
    private var _date: String!
    private var _time: String!
    private var _sunrise: String!
    private var _sunset: String!
    private var _temp: String!
    private var _humidity: String!
    private var _pressure: String!
    private var _windSpeed: String!
    private var _windDirection: WindDirection!
    
    private var _weatherURL: String!
    
    enum WindDirection {
        case N
        case NNE
        case NE
        case ENE
        case E
        case ESE
        case SE
        case SSE
        case S
        case SW
        case SSW
        case WSW
        case W
        case WNW
        case NW
        case NNW
    }
    
    //Creating getters
    var windSpeed: String {
        get {
            return _windSpeed
        }
    }
    
    var windDirection: WindDirection {
        get {
            return _windDirection
        }
    }
    
    var location: String {
        get {
            return _location
        }
    }
    
    var cityName: String {
        get {
            return _cityName
        }
    }
    
    var name: String {
        get {
            if _name == nil {
                return ""
            }
            return _name
        }
    }
    
    var shortDescription: String {
        get {
            if _shortDescription == nil {
                return ""
            }
            return _shortDescription
        }
    }
    
    var longDescription: String {
        get {
            if _longDescription == nil {
                return ""
            }
            return _longDescription
        }
    }
    
    var icon: String {
        get {
            if _icon == nil {
                return ""
            }
            return _icon
        }
    }
    
    
    var day: String {
        get {
            if _day == nil {
                return ""
            }
            return _date
        }
    }
    
    var date: String {
        get {
            if _date == nil {
                return ""
            }
            return _date
        }
    }
    
    var time: String {
        get {
            if _time == nil {
                return ""
            }
            return _time
        }
    }
    
    var sunrise: String {
        get {
            if _sunrise == nil {
                return ""
            }
            return _sunrise
        }
    }
    
    var sunset: String {
        get {
            if _sunset == nil {
                return ""
            }
            return _sunset
        }
    }
    
    var temp: String {
        get {
            if _temp == nil {
                return ""
            }
            return _temp
        }
    }
    
    var humidity: String {
        get {
            if _humidity == nil {
                return ""
            }
            return _humidity
        }
    }
    
    var pressure: String {
        get {
            if _pressure == nil {
                return ""
            }
            return _pressure
        }
    }
    
    //Initialize
    init(location: String, cityName: String) {
        self._location = "Seoul, KR"
        self._cityName = URL_CITY
        
        self._weatherURL = "\(URL_BASE)\(self._cityName)\(URL_UNITS)\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: self._weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let dt = dict["dt"] as? Double {
                    let date = NSDate(timeIntervalSince1970: dt)
                    let dayFormatter = NSDateFormatter()
                    let dateFormatter = NSDateFormatter()
                    let timeFormatter = NSDateFormatter()
                    dayFormatter.dateFormat = "EEEE"
                    dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
                    timeFormatter.dateFormat = "h:mm a"
                    self._day = dayFormatter.stringFromDate(date)
                    self._date = dateFormatter.stringFromDate(date)
                    self._time = timeFormatter.stringFromDate(date)
                }
                
                if let name = dict["name"] as? String {
                    self._name = name
                }
                
                if let weatherDet1 = dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDet1.count > 0 {
                    if let shortDesc = weatherDet1[0]["main"] as? String {
                        self._shortDescription = shortDesc
                    }
                    
                    if let longDesc = weatherDet1[0]["description"] as? String {
                        self._longDescription = longDesc.capitalizedString
                    }
                    
                    if let icon = weatherDet1[0]["icon"] as? String {
                        self._icon = icon
                    }
                }
                
                if let mainDet1 = dict["main"] as? Dictionary<String, AnyObject> {
                    if let tmp = mainDet1["temp"] as? Double {
                        self._temp = NSString(format: "%.0f", tmp) as String
                    }
                    
                    if let pres = mainDet1["pressure"] as? Double {
                        self._pressure = NSString(format: "%.2f", pres) as String
                    }
                    
                    if let hum = mainDet1["humidity"] as? Double {
                        self._humidity = NSString(format: "%.0f", hum) as String
                    }
                }
                
                if let windDet1 = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = windDet1["speed"] as? Double {
                        self._windSpeed = NSString(format: "%.0f", speed) as String
                    }
                    
                    if let direc = windDet1["deg"] as? Double {
                        switch (direc) {
                        case 348.75...360:
                            self._windDirection = WindDirection.N
                        case 0..<11.25:
                            self._windDirection = WindDirection.N
                        case 11.25..<33.75:
                            self._windDirection = WindDirection.NNE
                        case 33.75..<56.25:
                            self._windDirection = WindDirection.NE
                        case 56.25..<78.75:
                            self._windDirection = WindDirection.ENE
                        case 78.75..<101.25:
                            self._windDirection = WindDirection.E
                        case 101.25..<123.75:
                            self._windDirection = WindDirection.ESE
                        case 123.75..<146.25:
                            self._windDirection = WindDirection.SE
                        case 146.25..<168.75:
                            self._windDirection = WindDirection.SSE
                        case 168.75..<191.25:
                            self._windDirection = WindDirection.S
                        case 191.25..<213.75:
                            self._windDirection = WindDirection.SSW
                        case 213.75..<236.25:
                            self._windDirection = WindDirection.SW
                        case 236.26..<258.75:
                            self._windDirection = WindDirection.WSW
                        case 258.75..<281.25:
                            self._windDirection = WindDirection.W
                        case 281.25..<303.75:
                            self._windDirection = WindDirection.WNW
                        case 303.75..<326.25:
                            self._windDirection = WindDirection.NW
                        case 326.25..<348.75:
                            self._windDirection = WindDirection.NNW
                        default:
                            self._windDirection = WindDirection.N
                        }
                        
                    }
                }
                
                if let sysDet1 = dict["sys"] as? Dictionary<String, AnyObject> {
                    if let sunrise = sysDet1["sunrise"] as? Double {
                        let date = NSDate(timeIntervalSince1970: sunrise)
                        let timeFormatter = NSDateFormatter()
                        timeFormatter.dateFormat = "h.mma"
                        self._sunrise = timeFormatter.stringFromDate(date)
                    }
                    if let sunset = sysDet1["sunset"] as? Double {
                        let date = NSDate(timeIntervalSince1970: sunset)
                        let timeFormatter = NSDateFormatter()
                        timeFormatter.dateFormat = "h.mma"
                        self._sunset = timeFormatter.stringFromDate(date)
                    }
                }
                
            }
            completed()
        
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}