//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct CurrentWeatherViewModel {
    private let currentWeather: CurrentWeather
    private let dateFormatter = DateFormatter()
    
    //UseCases
    private let measurementUnitSettingsUseCase = MeasurementUnitSettingsUseCaseImp.shared
    private let measurementUnitDisplayUseCase = MeasurementUnitDisplayUseCaseImp.shared
}

extension CurrentWeatherViewModel {
    init(_ currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
}

extension CurrentWeatherViewModel {
    
    var temperature: String {
        if let _temperature = self.currentWeather.main.temp {
            let savedUserMeasurementUnit = measurementUnitSettingsUseCase.get()
            let unit = measurementUnitDisplayUseCase.getTemperatureUnitDisplayText(measurementUnit: savedUserMeasurementUnit)
            return "\(_temperature)\(unit))"
        }
        return "N/A"
    }
    
    var author: String {
        if let _author = self.article.author {
            return _author
        }
        return ""
    }
    
    var title: String {
        return self.article.title
    }
    
    var description: String {
        if let _description = self.article.articleDescription {
            return _description
        }
        return "Description unavailable"
    }
    
    var url: String {
        return self.article.url
    }
    
    var urlToImage: String {
        if let _urlToImage = self.article.urlToImage {
            return _urlToImage
        }
        return ""
    }
    
    var publishedAt: String {
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let datePublished = dateFormatter.date(from: self.article.publishedAt)
          
     //   dateFormatter.dateFormat = "dd MMM, yyyy"
     //   let friendlyDate = dateFormatter.string(from: datePublished!)
        return datePublished!.timeAgoDisplay()
    }
    
    var content: String {
        if let _content = self.article.content {
            return _content
        }
        return "Content unavailable"
    }
    
    var subtitle: String {
        var _subtitle = self.author
        
        if !_subtitle.isEmpty {
            _subtitle = "\(_subtitle) ∙ "
        }
        
        _subtitle = "\(_subtitle)\(self.publishedAt)"
        return _subtitle
    }
}
