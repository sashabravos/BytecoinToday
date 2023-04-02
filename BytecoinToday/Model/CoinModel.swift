//
//  CoinModel.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 02.04.2023.
//

import Foundation

struct CoinModel {
    let rateValue: Double
    let currencyName: String
    let btcName: String
    
    var currencyString: String {
        return String(format: "%.2f", rateValue)
    }
}
