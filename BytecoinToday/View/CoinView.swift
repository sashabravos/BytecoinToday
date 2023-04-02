//
//  CoinView.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 01.04.2023.
//

import UIKit

protocol CoinViewDelegate: AnyObject {
}

final class CoinView: UIView {
    
    var delegate: CoinViewDelegate?
    var config = ConfigurationView()
    
    lazy var pickerView = config.makePickerView()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = config.makeStackView(.vertical, .center, 25.0)
        
        [byteCoinLabel, coinView].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private lazy var coinView: UIView = {
        let view = config.makeView()
        view.backgroundColor = .tertiaryLabel
        view.layer.cornerRadius = 45.0
        
        view.addSubview(coinStackView)
        coinStackView.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var byteCoinLabel = config.makeLabel("ByteCoin", .center, 50.0, .thin)
    private lazy var coinStackView: UIStackView = {
        let stackView = config.makeStackView(.horizontal, .center, 10.0)
        
        [bitCoinImage, valueLabel, currencyLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackView
    }()
    
    private lazy var bitCoinImage: UIImageView = {
        let coin = config.makeImageView(UIImage(systemName: "bitcoinsign.circle.fill") ?? UIImage())
        coin.tintColor = (UIColor(named: "IconColor") ?? UIColor())
        return coin
    }()
    
    public lazy var valueLabel = config.makeLabel("...", .right, 25.0, .regular)
    
    public lazy var currencyLabel = config.makeLabel("USD", .right, 25.0, .regular)
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Add constraints
    func addSubView() {
        
        self.backgroundColor = UIColor(named: "BackgroundColor")
        
        [pickerView, headerStackView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            headerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            headerStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            
            pickerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            pickerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 216.0),
            
            byteCoinLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 230.0),
            byteCoinLabel.heightAnchor.constraint(equalToConstant: 60.0),
            
            coinView.heightAnchor.constraint(equalToConstant: 80.0),
            coinView.bottomAnchor.constraint(equalTo: coinStackView.bottomAnchor),
            coinView.topAnchor.constraint(equalTo: coinStackView.topAnchor),
            coinView.leadingAnchor.constraint(equalTo: coinStackView.leadingAnchor),
            coinView.trailingAnchor.constraint(equalTo: coinStackView.trailingAnchor, constant: 10.0),

            bitCoinImage.topAnchor.constraint(equalTo: coinStackView.topAnchor),
            bitCoinImage.bottomAnchor.constraint(equalTo: coinStackView.bottomAnchor),
            bitCoinImage.leadingAnchor.constraint(equalTo: coinStackView.leadingAnchor, constant: 2.0),
            bitCoinImage.widthAnchor.constraint(equalToConstant: 77.0)
        ])
    }
}
