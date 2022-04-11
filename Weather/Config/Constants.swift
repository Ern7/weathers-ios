//
//  Constants.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct Constants {
    
    struct AppConfig {
        static let BackendUrl = "https://api.openweathermap.org/";
        static let DEBUG_MODE = true;
    }

    struct ApiKeys {
        //These keys should not be here. Only putting them here for demo purposes only
        //.. but ideally these keys should not be in the code for obvious security reasons.
        static let OpenWeatherApiKey = "";
    }
    
    struct Font {
        static let bold = "Montserrat-Bold";
        static let regular = "Montserrat-Regular";
        static let medium = "Montserrat-Medium";
        static let semiBold = "Montserrat-SemiBold";
        static let thin = "Montserrat-Thin";
    }
    
    struct AppPalette {
        static let primaryColor = "#54717A";
        static let invisibleGrey = "#C1D2D8"
        static let pageBackgroundGrey = "#F8F8F8"
        static let sunnyPageBackgroundGreen = "#47AB2F"
        static let cloudyPageBackgroundGrey = "#54717A"
        static let rainyPageBackgroundGrey = "#57575D"
    }
    
    struct UserDefaultsKeys {
        static let MeasurementUnit = "MeasurementUnit";
    }
    
    struct CellIdentifiers {
        static let dayTableViewCell = "dayTableViewCell";
    }
    
    struct CurrentWeatherBackgroundImageNames {
        static let forestSunny = "forest_sunny";
        static let forestRainy = "forest_rainy"
        static let forestCloudy = "forest_cloudy"
    }
    
}

