//
//  ForecastDayListViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

class ForecastDayListViewModel {
    private var forecastDaysList: [ForecastDay]
    
    init(forecastDaysList: [ForecastDay]) {
        self.forecastDaysList = forecastDaysList
    }
}

extension ForecastDayListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.forecastDaysList.count
    }
    
    func timeStampDataAtIndex(_ index: Int) -> ForecastDayViewModel {
        let forecastDay = self.forecastDaysList[index]
        return ForecastDayViewModel(forecastDay)
    }
    
    func refreshList(_ forecastDaysList: [ForecastDay]) {
        clearItems()
        self.forecastDaysList.append(contentsOf: forecastDaysList)
    }
    
    func addMore(_ forecastDaysList: [ForecastDay]) {
        self.forecastDaysList.append(contentsOf: forecastDaysList)
    }
    
    func clearItems() {
        if !self.forecastDaysList.isEmpty {
            self.forecastDaysList.removeAll()
        }
    }
    
    func numberOfItems() -> Int {
        return self.forecastDaysList.count
    }
    
}
