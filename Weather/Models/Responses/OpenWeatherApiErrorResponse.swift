//
//  OpenWeatherApiErrorResponse.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct OpenWeatherApiErrorResponse : Codable {
    let cod : Int
    let message: String
}
