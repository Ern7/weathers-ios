//
//  City.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population, timezone, sunrise, sunset: Int
}
