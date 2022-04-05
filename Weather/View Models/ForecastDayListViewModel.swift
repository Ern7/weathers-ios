//
//  ForecastDayListViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

class ForecastDayListViewModel : BaseViewModel {
    
    private var forecastDaysList: [ForecastDay]?
    
    //UseCases
    private let measurementUnitSettingsUseCase = MeasurementUnitSettingsUseCaseImp.shared
    private let forecastUseCase = ForecastUseCaseImp.shared
}

extension ForecastDayListViewModel {
    func fetchForecast(latitude : Double, longitude : Double){
        self.needsToShowLoading?()
        let measurementUnit = measurementUnitSettingsUseCase.get()
        forecastUseCase.get(latitude: latitude, longitude: longitude, measurementUnit: measurementUnit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("ForecastDayListViewModel fetchForecast finished")
                case .failure(let error):
                    DebuggingLogger.printData("ForecastDayListViewModel fetchForecast results error: \(error.message)")
                    self.needsToShowError?(error)
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("ForecastDayListViewModel fetchForecast results: \(value)")
                self?.forecastDaysList = self?.forecastUseCase.convertToForecastDayList(timeStampDataList: value.list)
                self?.needsToUpdateViewWithNewData?()
            }).store(in: &observers)
    }
}

extension ForecastDayListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.forecastDaysList!.count
    }
    
    func timeStampDataAtIndex(_ index: Int) -> ForecastDayViewModel {
        let forecastDay = self.forecastDaysList![index]
        return ForecastDayViewModel(forecastDay)
    }
    
    func refreshList(_ forecastDaysList: [ForecastDay]) {
        clearItems()
        self.forecastDaysList!.append(contentsOf: forecastDaysList)
    }
    
    func addMore(_ forecastDaysList: [ForecastDay]) {
        self.forecastDaysList!.append(contentsOf: forecastDaysList)
    }
    
    func clearItems() {
        if !self.forecastDaysList!.isEmpty {
            self.forecastDaysList!.removeAll()
        }
    }
    
    func numberOfItems() -> Int {
        return self.forecastDaysList!.count
    }
    
}
