//
//  CoinData.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 02.04.2023.
//

import Foundation

struct CoinData: Codable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
