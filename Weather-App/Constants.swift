//
//  Constants.swift
//  Weather-App
//
//  Created by 조웅희 on 2016. 2. 16..
//  Copyright © 2016년 Sweet Acorn. All rights reserved.
//

import Foundation

public let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?q="
public let URL_CITY = "Seoul"
public let URL_UNITS = "&units=metric&appid="
public let API_KEY = "be0dd99d03246502f7e66e2b84d49641"

typealias DownloadComplete = () -> ()