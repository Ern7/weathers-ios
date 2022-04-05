//
//  DebuggingLogger.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct DebuggingLogger {
    
    static func printData(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        if Constants.AppConfig.DEBUG_MODE {
            print(items, separator: separator, terminator: terminator)
        }
    }
}
