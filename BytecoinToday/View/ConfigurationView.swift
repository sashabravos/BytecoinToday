//
//  UIViewCreator.swift
//  BytecoinToday
//
//  Created by Александра Кострова on 01.04.2023.
//

import UIKit

final class ConfigurationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func makeImageView(_ image: UIImage) -> UIImageView {
        let someImage = UIImageView.init(image: image)
        someImage.contentMode = .scaleAspectFill
        return someImage
    }
    
    public func makeView() -> UIView {
        let newView = UIView()
        newView.backgroundColor = .clear
        newView.contentMode = .scaleToFill
        return newView
    }
    
    public func makeStackView(_ axis: NSLayoutConstraint.Axis,
                              _ alignment: UIStackView.Alignment,
                              _ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = .fill
        stackView.alignment = alignment
        stackView.spacing = spacing
        stackView.contentMode = .scaleToFill
        return stackView
    }
    
    public func makeLabel(_ title: String,
                          _ textAlignment: NSTextAlignment,
                          _ fontSize: CGFloat,
                          _ fontWeight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = title
        label.numberOfLines = 1
        label.textColor = UIColor(named: "TitleColor")
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textAlignment = textAlignment
        label.contentMode = .left
        label.isEnabled = true
        return label
    }
    
    public func makePickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        return pickerView
    }
    
    public func setMyView(_ myView: UIView, _ replaceView: UIView) {
        replaceView.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: replaceView.topAnchor),
            myView.leadingAnchor.constraint(equalTo: replaceView.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: replaceView.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: replaceView.bottomAnchor)
        ])
    }
    
    private enum Constants {
        static let buttonFontSize: CGFloat = 15.0
        static let textFieldFontSize: CGFloat = 25.0
        static let textFieldMinFontSize: CGFloat = 12.0
    }
}

