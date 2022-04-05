//
//  HomeViewController.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import UIKit

class HomeViewController: UIViewController {
    
    var currentWeatherViewModel: CurrentWeatherViewModel?
    var forecastDayListViewModel: ForecastDayListViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModels()
    }
    
    private func bindViewModels(){
        bindCurrentWeatherViewModel()
        bindForecastDayListViewModel()
    }
    
    private func bindCurrentWeatherViewModel(){
        currentWeatherViewModel = CurrentWeatherViewModel()
        currentWeatherViewModel!.needsToUpdateViewWithNewData = { [weak self] in
            DebuggingLogger.printData("HomeViewController fetchCurrentWeather finished \(self?.currentWeatherViewModel!.title)")
        }
        currentWeatherViewModel!.needsToShowLoading = { [weak self] in
            DebuggingLogger.printData("HomeViewController fetchCurrentWeather loading...")
        }
        currentWeatherViewModel!.needsToShowError = { [weak self] error in
            DebuggingLogger.printData("HomeViewController fetchCurrentWeather error: \(error.message)")
        }
        fetchCurrentWeather()
    }
    
    private func bindForecastDayListViewModel(){
        forecastDayListViewModel = ForecastDayListViewModel()
        forecastDayListViewModel!.needsToUpdateViewWithNewData = { [weak self] in
            DebuggingLogger.printData("HomeViewController fetchForecast finished \(self?.forecastDayListViewModel!.timeStampDataAtIndex(0).day)")
        }
        forecastDayListViewModel!.needsToShowLoading = { [weak self] in
            DebuggingLogger.printData("HomeViewController fetchForecast loading...")
        }
        forecastDayListViewModel!.needsToShowError = { [weak self] error in
            DebuggingLogger.printData("HomeViewController fetchForecast error: \(error.message)")
        }
        fetchForecast()
    }
    
    private func fetchCurrentWeather(){
        currentWeatherViewModel?.fetchCurrentWeather(latitude: -25.8640, longitude: 28.0889)
    }
    
    private func fetchForecast(){
        forecastDayListViewModel?.fetchForecast(latitude: -25.8640, longitude: 28.0889)
    }

    //MARK: - Activity Indicator methods
/*    func showLoader() {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }   */

}
