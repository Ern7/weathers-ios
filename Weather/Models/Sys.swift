//
//  Sys.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}
