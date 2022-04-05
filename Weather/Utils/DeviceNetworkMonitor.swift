//
//  DeviceNetworkMonitor.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Network

class DeviceNetworkMonitor {
    
    let networkMonitor = NWPathMonitor()
    var isDeviceConnectedToInternet: Bool = false
    static let shared = DeviceNetworkMonitor()
    
    func startMonitoring() {
        networkMonitor.pathUpdateHandler = { path in
           if path.status == .satisfied {
               DebuggingLogger.printData("Device is connected to internet - isExpensive : \(path.isExpensive)")
               self.isDeviceConnectedToInternet = true
           } else {
               DebuggingLogger.printData("Device is connected to internet - isExpensive : \(path.isExpensive)")
               self.isDeviceConnectedToInternet = false
           }
        }
        let networkQueue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: networkQueue)
    }
    
    func stopMonitoring() {
        networkMonitor.cancel()
    }
}
