//
//  TimeStampData.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct TimeStampData: Codable {
    let dt: Int64
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int?
    let pop: Double?
    let sys: TimeStampSys
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

struct TimeStampSys: Codable {
    let pod: String?
}
