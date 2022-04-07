//
//  LocationPermissionUtils.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/07.
//

import Foundation
import CoreLocation
import UIKit

struct LocationPermissionUtils {
    
    static func hasLocationPermission() -> Bool {
        var hasPermission = false
        let manager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            @unknown default:
                    break
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
}
