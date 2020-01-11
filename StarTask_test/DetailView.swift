//
//  DetailView.swift
//  StarTask_test
//
//  Created by Gravman on 11.01.2020.
//  Copyright © 2020 Alexandr_P. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactSurname: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var phoneType: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
}


extension DetailView {
    func setData(_ model: ContactRealm?) {
          phoneNumberTextField.text = model?.phoneNumber ?? ""
          nameTextField.text = model?.firstName ?? ""
          lastNameTextField.text = model?.lastName ?? ""
      }
}
