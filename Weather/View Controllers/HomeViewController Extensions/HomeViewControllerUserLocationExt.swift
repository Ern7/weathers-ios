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
        if self.permissionsAlert != nil {
            self.permissionsAlert!.dismiss(animated: true, completion: nil)
        }
        
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
                         if let sublocality = placemark.subLocality, let locality = placemark.locality {
                             DebuggingLogger.printData("CLGeocoder().reverseGeocodeLocation Place name: \(sublocality), \(locality)")
                         }
                     }
                 }
             }
        }
        
        
    }
    
    // MARK: - UI methods
    func displayUserLocationErrorAlert(){
        DispatchQueue.main.async {
            
            self.permissionsAlert = UIAlertController(title: "Location Permissions Required", message: "MyWeather requires location permissions inorder to fetch the weather in your currrent location. Please grant location permissions in your Device Settings and reopen the app.", preferredStyle: .alert)

            self.permissionsAlert!.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { action in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }))
            
            self.present(self.permissionsAlert!, animated: true, completion: nil)
        }
    }

}


