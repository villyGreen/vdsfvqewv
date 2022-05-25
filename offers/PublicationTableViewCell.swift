//
//  PublicationTableViewCell.swift
//  offers
//
//  Created by zz on 25.05.2022.
//  Copyright © 2022 Vadim Vitkovskiy. All rights reserved.
//


import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UITextField {
    
  func setupTextField(placeHolder: String) {
      self.translatesAutoresizingMaskIntoConstraints = false
      self.font = UIFont.systemFont(ofSize: 13)

      self.borderStyle = .none
      self.textColor = .black
      self.autocorrectionType = UITextAutocorrectionType.no
      self.keyboardType = UIKeyboardType.default
      self.returnKeyType = UIReturnKeyType.done
      self.attributedPlaceholder = NSAttributedString(
          string: placeHolder,
          attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x999999)]
      )
      self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
  }

}

import UIKit

class PublicationTableViewCell: UITableViewCell {
    let button = UITextField()
    let datePicker = UIDatePicker()
    static let id = "Publications"
    func configure(placeHolder: String) {
    

        button.setupTextField(placeHolder: placeHolder)
        
        let stackview = UIStackView(arrangedSubviews: [button, datePicker ])
        stackview.axis = .horizontal
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackview)
        NSLayoutConstraint.activate([
            datePicker.heightAnchor.constraint(equalToConstant: 50),
            datePicker.widthAnchor.constraint(equalToConstant: 100),
            stackview.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            stackview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            stackview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            stackview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
        
        
    }
}




class PersonalDetails: UITableViewCell {
 
    var label = UITextField()
    var pickerView = UIPickerView()
    var isHiden = false
    static let id = "PersonalDetails"
    private let dataSource = ["Male", "Female"]
    func customInit(isPicker: Bool) {
    
        pickerView.overrideUserInterfaceStyle = .dark
        pickerView.delegate = self
        pickerView.dataSource = self
     
        label.setupTextField(placeHolder: "Language")
        
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)
        self.contentView.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.tintColor = .red
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            pickerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            pickerView.widthAnchor.constraint(equalToConstant: 100),
            pickerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        pickerView.isHidden = isPicker
    
    }
}

extension PersonalDetails : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
         if let v = view as? UILabel { label = v }
         label.font = UIFont (name: "Helvetica Neue", size: 14)
         label.text =  dataSource[row]
        label.textColor = UIColor(rgb: 0x4361EE)
         label.textAlignment = .center
         return label
    }

}

