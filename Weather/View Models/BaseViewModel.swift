//
//  BaseViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

class BaseViewModel {
    
    //View Callbacks
    var needsToUpdateViewWithNewData : (() -> Void)?
    var needsToShowError : ((APICallError) -> Void)?
    var needsToShowLoading : (() -> Void)?
    
    //OBSERVERS
    var observers: [AnyCancellable] = []
    
}


