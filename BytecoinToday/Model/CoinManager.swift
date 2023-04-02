//
//  CoinManager.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 01.04.2023.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateData(_ coinManager: CoinManager, coinRate: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "ADD_YOUR_API_KEY"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        self.performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task  = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let coinRate = self.parseJSON(safeData) {
                        self.delegate?.didUpdateData(self, coinRate: coinRate)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let btc = decodedData.asset_id_base
            
            let coinRate = CoinModel(rateValue: rate, currencyName: currency, btcName: btc)
            return coinRate
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
