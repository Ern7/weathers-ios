//
//  HomeViewControllerTableViewExt.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/06.
//

import Foundation
import UIKit

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func setupTableViewDelegatesAndDataSource(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.forecastDayListViewModel!.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastDayListViewModel!.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let forecastDayViewModel = self.forecastDayListViewModel!.timeStampDataAtIndex(indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.dayTableViewCell, for: indexPath) as? DayTableViewCell else {
            fatalError()
        }
        cell.dayLabel?.text = forecastDayViewModel.day
        cell.temperatureLabel?.text = forecastDayViewModel.temperature
        cell.iconImageView.image = UIImage(named: forecastDayViewModel.iconName)
        
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /*
        if indexPath.row == self.forecastDayListViewModel!.numberOfItems() - 1 {
            self.loadMore()
        }
         */
    }

    func showTableView() {
        self.tableView.isHidden = false
    }
    
    func hideTableView(){
        self.tableView.isHidden = true
    }
    
    func updateTableViewBackgroundColor(hexColor: String){
        self.tableView.backgroundColor = ColorUtils.hexStringToUIColor(hex: hexColor)
    }
    
    // MARK: - HEADER VIEW (CURRENT WEATHER VIEW)
    func adaptHeaderView(){
        self.headerMinTemperatureLabel.text = self.currentWeatherViewModel!.minimumTemperature
        self.headerMaxTemperatureLabel.text = self.currentWeatherViewModel!.maxTemperature
        self.headerCurrentTemperatureLabel.text = self.currentWeatherViewModel!.currentTemperature
        self.headerTemperatureLabel.text = self.currentWeatherViewModel!.currentTemperature
        self.headerTitleLabel.text = self.currentWeatherViewModel!.title
        
        self.headerBackgroundImageView.image = UIImage(named: self.currentWeatherViewModel!.pageBackgroundImageName)
        self.headerView.frame = CGRect(x: self.headerView.frame.origin.x, y: self.headerView.frame.origin.y, width: self.headerView.frame.width, height: self.currentWeatherViewModel!.getHeaderHeight(viewWidth: self.headerView.frame.width))
    }
}
