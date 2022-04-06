//
//  HomeViewController.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    //UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    @IBOutlet weak var headerMinTemperatureLabel: UILabel!
    @IBOutlet weak var headerCurrentTemperatureLabel: UILabel!
    @IBOutlet weak var headerMaxTemperatureLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerTemperatureLabel: UILabel!
    
    //VIEW MODELS
    var currentWeatherViewModel: CurrentWeatherViewModel?
    var forecastDayListViewModel: ForecastDayListViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModels()
        setupTableViewDelegatesAndDataSource()
        bindViewModels()
        fetchCurrentWeather()
    }
    
    // MARK: - VIEWMODEL METHODS
    private func initializeViewModels(){
        currentWeatherViewModel = CurrentWeatherViewModel()
        forecastDayListViewModel = ForecastDayListViewModel()
    }
    
    private func bindViewModels(){
        bindCurrentWeatherViewModel()
        bindForecastDayListViewModel()
    }
    
    private func bindCurrentWeatherViewModel(){
        currentWeatherViewModel!.needsToUpdateViewWithNewData = { [weak self] in
            self?.fetchForecast()
            self?.adaptHeaderView()
            self?.updateTableViewBackgroundColor(hexColor: (self?.currentWeatherViewModel!.pageBackgroundColor)!)
        }
        currentWeatherViewModel!.needsToShowLoading = { [weak self] in
            self?.showLoader()
        }
        currentWeatherViewModel!.needsToShowError = { [weak self] error in
            DebuggingLogger.printData("HomeViewController fetchCurrentWeather error: \(error.message)")
        }
    }
    
    private func bindForecastDayListViewModel(){
        forecastDayListViewModel!.needsToUpdateViewWithNewData = { [weak self] in
            self?.tableView.reloadData()
            self?.showTableView()
            self?.hideLoader()
        }
        forecastDayListViewModel!.needsToShowLoading = { [weak self] in
            self?.showLoader()
        }
        forecastDayListViewModel!.needsToShowError = { [weak self] error in
            DebuggingLogger.printData("HomeViewController fetchForecast error: \(error.message)")
        }
    }
    
    //MARK: DATA FETCH METHODS
    private func fetchCurrentWeather(){
        currentWeatherViewModel?.fetchCurrentWeather(latitude: -25.8640, longitude: 28.0889)
    }
    
    private func fetchForecast(){
        forecastDayListViewModel?.fetchForecast(latitude: -25.8640, longitude: 28.0889)
    }

    //MARK: - Activity Indicator methods
    func showLoader() {
        DispatchQueue.main.async {
          //  self.errorView.isHidden = true
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
            self.hideTableView()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
    

}
