//
//  ForecastListViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

class TimeStampDataListViewModel {
    private var timeStampDataList: [TimeStampData]
    
    init(timeStampDataList: [TimeStampData]) {
        self.timeStampDataList = timeStampDataList
    }
}

extension TimeStampDataListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.timeStampDataList.count
    }
    
    func timeStampDataAtIndex(_ index: Int) -> TimeStampDataViewModel {
        let timeStampData = self.timeStampDataList[index]
        return TimeStampDataViewModel(timeStampData)
    }
    
    func refreshList(_ timeStampDataList: [TimeStampData]) {
        clearItems()
        self.timeStampDataList.append(contentsOf: timeStampDataList)
    }
    
    func addMore(_ timeStampDataList: [TimeStampData]) {
        self.timeStampDataList.append(contentsOf: timeStampDataList)
    }
    
    func clearItems() {
        if !self.timeStampDataList.isEmpty {
            self.timeStampDataList.removeAll()
        }
    }
    
    func numberOfItems() -> Int {
        return self.timeStampDataList.count
    }
    
}
