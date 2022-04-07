//
//  HomeViewController.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import UIKit
import CoreLocation

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
    var errorView: FeedbackErrorView?
    
    //VIEW MODELS
    var currentWeatherViewModel: CurrentWeatherViewModel?
    var forecastDayListViewModel: ForecastDayListViewModel?
    
    //USER LOCATION
    var manager = CLLocationManager()
    var currentLocation : CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupErrorView()
        initializeViewModels()
        setupTableViewDelegatesAndDataSource()
        bindViewModels()
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
            self?.showErrorView(title: "Error", description: error.message)
        }
    }
    
    private func bindForecastDayListViewModel(){
        forecastDayListViewModel!.needsToUpdateViewWithNewData = { [weak self] in
            self?.tableView.reloadData()
            self?.showTableView()
            self?.hideLoader()
            self?.hideErrorView()
        }
        forecastDayListViewModel!.needsToShowLoading = { [weak self] in
            self?.showLoader()
        }
        forecastDayListViewModel!.needsToShowError = { [weak self] error in
            self?.showErrorView(title: "Error", description: error.message)
        }
    }
    
    //MARK: DATA FETCH METHODS
    func fetchCurrentWeather(){
        if currentLocation != nil {
            currentWeatherViewModel?.fetchCurrentWeather(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
        }
        else {
            displayUserLocationErrorMessage()
        }
    }
    
    private func fetchForecast(){
        if currentLocation != nil {
            forecastDayListViewModel?.fetchForecast(latitude: currentLocation!.coordinate.latitude, longitude: currentLocation!.coordinate.longitude)
        }
        else {
            displayUserLocationErrorMessage()
        }
    }

    //MARK: - Activity Indicator methods
    func showLoader() {
        DispatchQueue.main.async {
            self.hideErrorView()
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
