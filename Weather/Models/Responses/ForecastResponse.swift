//
//  ForecastResponse.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct ForecastResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [TimeStampData]
    let city: City
}




