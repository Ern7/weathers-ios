//
//  APICallError.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct APICallError: Error {
    enum ErrorKind {
        case decodingError
        case domainError
        case urlError
        case serverError
        case internetConnectionError
    }

    let message: String
    let kind: ErrorKind
}
