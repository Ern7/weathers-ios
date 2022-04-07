//
//  HomeViewControllerErrorExt.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/07.
//

import Foundation
import UIKit

extension HomeViewController {
    
    func setupErrorView(){
        errorView = FeedbackErrorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        errorView!.needsToRefresh = { [weak self] in
            self?.fetchCurrentWeather()
        }
        self.view.addSubview(errorView!)
        hideErrorView()
    }
    
    func showErrorView(title: String, description: String){
        self.hideLoader()
        self.errorView!.isHidden = false
        self.errorView!.titleLabel.text = title
        self.errorView!.descriptionLabel.text = description
    }
    
    func hideErrorView(){
        errorView!.isHidden = true
        errorView!.titleLabel.text = ""
        errorView!.descriptionLabel.text = ""
    }
}
