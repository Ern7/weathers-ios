//
//  HomeViewControllerUserLocationExt.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/07.
//

import Foundation
import UIKit
import CoreLocation

extension HomeViewController : CLLocationManagerDelegate {
    
    // MARK: - Configurations
    func setupLocationManager(){
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var shouldFetchPlaces = false;
        if (currentLocation == nil){
            shouldFetchPlaces = true;
        }
        
        currentLocation = locations[0]
        if (shouldFetchPlaces){
            self.fetchCurrentWeather()
            
            CLGeocoder().reverseGeocodeLocation(currentLocation!){ (placemarks, error) in
                 if error != nil{
                     DebuggingLogger.printData("CLGeocoder().reverseGeocodeLocation error: \(error!)")
                 }
                 else{
                     if let placemark = placemarks?[0]{
                         DebuggingLogger.printData("CLGeocoder().reverseGeocodeLocation Place name: \(placemark.subLocality!), \(placemark.locality!)")
                     }
                 }
             }
        }
        
        
    }
    
    // MARK: - UI methods
    func displayUserLocationErrorMessage(){
        if LocationPermissionUtils.hasLocationPermission() {
            let alert = UIAlertController(title: "Error", message: "Something went wrong. Weather could not pick up your location.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
            }))

            self.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Location Permissions Required", message: "PlaSees requires location permissions inorder to work. Please grant location permissions in your Device Settings and reopen the app.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { action in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }))

            self.present(alert, animated: true)
        }
    }

}


