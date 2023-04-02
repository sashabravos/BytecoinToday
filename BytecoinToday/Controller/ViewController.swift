//
//  ViewController.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 31.03.2023.
//

import UIKit

class ViewController: UIViewController, CoinViewDelegate {
    
    let mainView = CoinView()
    let configuration = ConfigurationView()
    var coinManager = CoinManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
        coinManager.delegate = self
        configuration.setMyView(mainView, self.view)
        
        mainView.pickerView.dataSource = self
        mainView.pickerView.delegate = self
    }
}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateData(_ coinManager: CoinManager, coinRate: CoinModel) {
        DispatchQueue.main.async {
            self.mainView.valueLabel.text = coinRate.currencyString
            self.mainView.currencyLabel.text = coinRate.currencyName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.endIndex
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
}

